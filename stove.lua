-- this is a modified version of default/furnace.lua
-- All credit goes to the original coders
--This code is licenced as 
--GNU Lesser General Public License, version 2.1
--This mod uses code from Minetest Game's furnace (C) 2012-2025 Minetest Game Contributors, licensed under the GNU Lesser General Public license, version 2.1

-- List of sound handles for active stove
local stove_fire_sounds = {}

--
-- Formspecs
--

function default.get_stove_active_formspec(fuel_percent, item_percent)
	return "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;myappliances_stove_fire_bg.png^[lowpart:"..
		(fuel_percent)..":myappliances_stove_fire_fg.png]"..
		"image[3.75,1.5;1,1;gui_stove_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_stove_arrow_fg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;fuel]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function default.get_stove_inactive_formspec()
	return "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;myappliances_stove_fire_bg.png]"..
		"image[3.75,1.5;1,1;gui_stove_arrow_bg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;fuel]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

--
-- Node callback functions that are the same for active and inactive stove
--

local function can_dig(pos, player)
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if core.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if core.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", "stove is empty")
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if core.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function stop_stove_sound(pos, fadeout_step)
	local hash = core.hash_node_position(pos)
	local sound_ids = stove_fire_sounds[hash]
	if sound_ids then
		for _, sound_id in ipairs(sound_ids) do
			core.sound_fade(sound_id, -1, 0)
		end
		stove_fire_sounds[hash] = nil
	end
end

local function swap_node(pos, name)
	local node = core.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	core.swap_node(pos, node)
end

local function add_item_or_drop(inv, pos, item)
	local leftover = inv:add_item("dst", item)
	if not leftover:is_empty() then
		local above = vector.offset(pos, 0, 1, 0)
		local drop_pos = core.find_node_near(pos, 1, {"air"}) or above
		core.item_drop(leftover, nil, drop_pos)
	end
end

local function stove_node_timer(pos, elapsed)
	--
	-- Initialize metadata
	--
	local meta = core.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local cookable, cooked
	local fuel
	local update = true
	local items_smelt = 0
	while elapsed > 0 and update do
		update = false

		srclist = inv:get_list("src")
		fuellist = inv:get_list("fuel")

		--
		-- Cooking
		--

		-- Check if we have cookable content
		local aftercooked
		cooked, aftercooked = core.get_craft_result({method = "cooking", width = 1, items = srclist})
		cookable = cooked.time ~= 0

		local el = math.min(elapsed, fuel_totaltime - fuel_time)
		if cookable then -- fuel lasts long enough, adjust el to cooking duration
			el = math.min(el, cooked.time - src_time)
		end

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The stove is currently active and has enough fuel
			fuel_time = fuel_time + el
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + el
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)

						-- stop any final replacement from clogging "src"
						local can_cook = core.get_craft_result({
								method = "cooking", width = 1,
								items = {aftercooked.items[1]:to_string()}})
						can_cook = can_cook.time ~= 0 or not can_cook.item:is_empty()

						if aftercooked.items[1]:is_empty() or can_cook then
							-- cook the final "src" item in the next cycle
							inv:set_stack("src", 1, aftercooked.items[1])
						else
							-- the final "src" item was replaced and is not cookable
							inv:set_stack("src", 1, "")
							add_item_or_drop(inv, pos, aftercooked.items[1])
						end

						src_time = src_time - cooked.time
						update = true
						-- add replacement item to dst so they arent lost
						if cooked.replacements[1] then
							add_item_or_drop(inv, pos, cooked.replacements[1])
						end
					else
						dst_full = true
					end
					items_smelt = items_smelt + 1
				else
					-- Item could not be cooked: probably missing fuel
					update = true
				end
			end
		else
			-- stove ran out of fuel
			if cookable then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = core.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- prevent blocking of fuel inventory (for automatization mods)
					local is_fuel = core.get_craft_result({method = "fuel", width = 1, items = {afterfuel.items[1]:to_string()}})
					if is_fuel.time == 0 then
						table.insert(fuel.replacements, afterfuel.items[1])
						inv:set_stack("fuel", 1, "")
					else
						-- Take fuel from fuel list
						inv:set_stack("fuel", 1, afterfuel.items[1])
					end
					-- Put replacements in dst list or drop them on the stove.
					local replacements = fuel.replacements
					if replacements[1] then
						add_item_or_drop(inv, pos, replacements[1])
					end
					update = true
					fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = elapsed - el
	end

	if items_smelt > 0 then
		-- Play cooling sound
		core.sound_play("default_cool_lava",
			{ pos = pos, max_hear_distance = 16, gain = 0.07 * math.min(items_smelt, 7) }, true)
	end
	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end
	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		if dst_full then
			item_state = "100% (output full)"
		else
			item_state = "@1%", item_percent
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = "Not cookable"
		else
			item_state = "Empty"
		end
	end

	local fuel_state = "Empty"
	local active = false
	local result = false

	if fuel_totaltime ~= 0 then
		active = true
		local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = "@1%", fuel_percent
		formspec = default.get_stove_active_formspec(fuel_percent, item_percent)
		swap_node(pos, "myappliances:stove_active")
		-- make sure timer restarts automatically
		result = true

		-- Play sound every 5 seconds while the stove is active
		if timer_elapsed == 0 or (timer_elapsed + 1) % 5 == 0 then
			local sound_id = core.sound_play("default_stove_active",
				{pos = pos, max_hear_distance = 16, gain = 0.25})
			local hash = core.hash_node_position(pos)
			stove_fire_sounds[hash] = stove_fire_sounds[hash] or {}
			table.insert(stove_fire_sounds[hash], sound_id)
			-- Only remember the 3 last sound handles
			if #stove_fire_sounds[hash] > 3 then
				table.remove(stove_fire_sounds[hash], 1)
			end
			-- Remove the sound ID automatically from table after 11 seconds
			core.after(11, function()
				if not stove_fire_sounds[hash] then
					return
				end
				for f=#stove_fire_sounds[hash], 1, -1 do
					if stove_fire_sounds[hash][f] == sound_id then
						table.remove(stove_fire_sounds[hash], f)
					end
				end
				if #stove_fire_sounds[hash] == 0 then
					stove_fire_sounds[hash] = nil
				end
			end)
		end
	else
		if fuellist and not fuellist[1]:is_empty() then
			fuel_state = "@1%", 0
		end
		formspec = default.get_stove_inactive_formspec()
		swap_node(pos, "myappliances:stove")
		-- stop timer on the inactive stove
		core.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)

		stop_stove_sound(pos)
	end


	local infotext
	if active then
		infotext = "stove active"
	else
		infotext = "stove inactive"
	end
	infotext = infotext .. "\n" .. "(Item: @1; Fuel: @2)", item_state, fuel_state

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

--
-- Node definitions
--

local function apply_logger(def)
	default.set_inventory_action_loggers(def, "stove")
	return def
end

core.register_node("myappliances:stove", apply_logger({
	description = "Stove",
	tiles = {
			"myappliances_stove.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_stove.obj",
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_timer = stove_node_timer,

	on_construct = function(pos)
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('fuel', 1)
		inv:set_size('dst', 4)
		stove_node_timer(pos, 0)
	end,

	on_metadata_inventory_move = function(pos)
		core.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether stove can burn or not.
		core.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_take = function(pos)
		-- check whether the stove is empty or not.
		core.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "src", drops)
		default.get_inventory_drops(pos, "fuel", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "myappliances:stove"
		core.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
}))

core.register_node("myappliances:stove_active", apply_logger({
	description = "Stove",
	tiles = {
			"myappliances_stove_active.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_stove.obj",
	paramtype2 = "facedir",
	light_source = 8,
	drop = "myappliances:stove",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_timer = stove_node_timer,
	on_destruct = function(pos)
		stop_stove_sound(pos)
	end,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
}))
