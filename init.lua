dofile(core.get_modpath("myappliances").."/machine.lua")
dofile(core.get_modpath("myappliances").."/small_appliances.lua")
dofile(core.get_modpath("myappliances").."/stove.lua")



function core.get_myappliances_fridge(pos)
    local spos = pos.x .. "," .. pos.y .. "," ..pos.z
    local formspec =
        "size[9,7]"..
		"background[-0.15,-0.25;9.3,7.75;myfurniture_background.png]"..
        "list[nodemeta:".. spos .. ";main;0.5,0.5;8,2;]"..
        "list[current_player;main;0.5,3;8,4;]"..
        "listring[nodemeta:" .. spos .. ";main]" ..
        "listring[current_player;main]"
    return formspec
end
function core.get_myappliances_freezer(pos)
    local spos = pos.x .. "," .. pos.y .. "," ..pos.z
    local formspec =
        "size[9,7]"..
		"background[-0.15,-0.25;9.3,7.75;myfurniture_background.png]"..
        "list[nodemeta:".. spos .. ";main;0.5,0.5;8,1;]"..
        "list[current_player;main;0.5,3;8,4;]"..
        "listring[nodemeta:" .. spos .. ";main]" ..
        "listring[current_player;main]"
    return formspec
end

--[[Dishwasher
core.register_node("myappliances:dishwasher", {
	description = "Dishwasher",
	tiles = {
			"myappliances_dishwasher.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_dishwasher.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:dishwasher_open", param2 = node.param2})
	end
})
core.register_node("myappliances:dishwasher_open", {
	description = "Dishwasher",
	tiles = {
			"myappliances_dishwasher.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_dishwasher_open.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:dishwasher", param2 = node.param2})
	end	
})
--]]
core.register_node("myappliances:dishwasher", {
	description = "Dishwasher",
	tiles = {
			"myappliances_dishwasher_top.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_front.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
})

--Fridge
core.register_node("myappliances:fridge", {
	description = "Fridge",
	tiles = {
			"myappliances_fridge.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_fridge.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
	on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string("infotext", "Fridge")
        meta:set_string("owner", "")
        local inv = meta:get_inventory()
        inv:set_size("main", 9*7)
    end,
	
on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if core.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            core.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return core.item_place(itemstack, placer, pointed_thing)
    end,

    can_dig = function(pos,player)

		local meta = core.get_meta({x=pos.x,y=pos.y+1,z=pos.z});
		local inv = meta:get_inventory()
		if not inv:is_empty("ingot") then
			return false
		elseif not inv:is_empty("res") then
			return false
		end
        local meta = core.get_meta(pos);
        local inv = meta:get_inventory()

        return inv:is_empty("main")
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = core.get_meta(pos)

        return count
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        return stack:get_count()
    end,

    on_rightclick = function(pos, node, clicker)
        local meta = core.get_meta(pos)
    	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
            core.show_formspec(
                clicker:get_player_name(),
                "myappliances:"..spos.."_fridge",
                core.get_myappliances_fridge(pos)
            )
    end,
})

--Freezer
core.register_node("myappliances:freezer", {
	description = "Freezer",
	tiles = {
			"myappliances_freezer.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_freezer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.5},
		},
	on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string("infotext", "Freezer")
        meta:set_string("owner", "")
        local inv = meta:get_inventory()
        inv:set_size("main", 9*7)
    end,

    can_dig = function(pos,player)

		local meta = core.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
		local inv = meta:get_inventory()
		if not inv:is_empty("ingot") then
			return false
		elseif not inv:is_empty("res") then
			return false
		end
        local meta = core.get_meta(pos);
        local inv = meta:get_inventory()

        return inv:is_empty("main")
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = core.get_meta(pos)

        return count
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        return stack:get_count()
    end,

    on_rightclick = function(pos, node, clicker)
        local meta = core.get_meta(pos)
    	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
            core.show_formspec(
                clicker:get_player_name(),
                "myappliances:"..spos.."_freezer",
                core.get_myappliances_freezer(pos)
            )
    end,
})
--TV
core.register_node("myappliances:tv", {
	description = "TV",
	tiles = {
			"myappliances_tv.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_tv.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, 0.375, 0.5},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:tv_on", param2 = node.param2})
	end
})
--TV On
core.register_node("myappliances:tv_on", {
	description = "TV",
	tiles = {
			{name="myappliances_tv_on.png", animation={type="vertical_frames",
											aspect_w=16, aspect_h=16, length=0.8}},
			},
	drawtype = "mesh",
	mesh = "myappliances_tv.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, 0.375, 0.5},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:tv", param2 = node.param2})
	end
})
--TV w Stand
core.register_node("myappliances:tv_w_stand", {
	description = "TV With Stand",
	tiles = {
			"myappliances_tv.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_tv_with_stand.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0.375, 0.15},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:tv_w_stand_on", param2 = node.param2})
	end
})
--TV wit stand On
core.register_node("myappliances:tv_w_stand_on", {
	description = "TV",
	tiles = {
			{name="myappliances_tv_on.png", animation={type="vertical_frames",
											aspect_w=16, aspect_h=16, length=0.8}},
			},
	drawtype = "mesh",
	mesh = "myappliances_tv_with_stand.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, 0.375, 0.5},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:tv_w_stand", param2 = node.param2})
	end
})
--Stereo
core.register_node("myappliances:stereo", {
	description = "Stereo",
	tiles = {
			"myappliances_stereo.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_stereo.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0, 0.375},
		},
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos,{name = "myappliances:stereo_on", param2 = node.param2})
	end,
})

local player_handles = {}
local sound_playing = false

local function play_music(player)
	  local track = tostring(math.random(6))
	if player ~= nil then
      player_handles[player] = core.sound_play({name = track}, {pos = pos, gain = 1.0, max_hear_distance = 10, loop = false})
   	else
   		return
    end
end

local function music_stop(player)
	if player ~= nil then
   		core.sound_stop(player_handles[player])
   	else
   		return
   	end
end
core.register_node("myappliances:stereo_on", {
	description = "Stereo",
	tiles = {
			"myappliances_stereo_on.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_stereo.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0, 0.375},
		},
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local speakers = core.find_node_near(pos, 5, "myappliances:speaker", false)
		if speakers == nil then 
			return 
		end
core.chat_send_all(tostring(sound_playing))
		if speakers and sound_playing == false then
			play_music(clicker)
			sound_playing = true
		else
			if sound_playing == true then
				music_stop(clicker)
				sound_playing = false
			else
				return
			end
		end
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		if sound_playing == true then
			music_stop(puncher)
		end
			core.set_node(pos,{name = "myappliances:stereo", param2 = node.param2})
	end
})

--Floor Speakers
core.register_node("myappliances:speaker", {
	description = "Computer",
	tiles = {
			"myappliances_floorspeaker.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_floorspeaker.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, 0.125, 0.25, 0.5, 0.5},
		},
	}
})

--Washer
core.register_node("myappliances:washer", {
	description = "Washer",
	tiles = {
			"myappliances_washer.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_washer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	}
})
--Dryer
core.register_node("myappliances:dryer", {
	description = "Dryer",
	tiles = {
			"myappliances_dryer.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_dryer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	}
})

--Water Cooler
core.register_node("myappliances:watercooler", {
	description = "Water Cooler",
	tiles = {
			"myappliances_watercooler.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_watercooler.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},

	selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
		}
	},
	
on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if core.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            core.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return core.item_place(itemstack, placer, pointed_thing)
    end,
})

--Computer
core.register_node("myappliances:computer", {
	description = "Computer",
	tiles = {
			"myappliances_computer.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_computer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},

	selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:computer_on", param2 = node.param2})
	end
})

--Computer On
core.register_node("myappliances:computer_on", {
	description = "Computer",
	tiles = {
			"myappliances_computer_on.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_computer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},

	selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		core.set_node(pos, {name = "myappliances:computer", param2 = node.param2})
	end
})

--Hotwater Heater
core.register_node("myappliances:hotwater_heater", {
	description = "Hotwater Heater",
	tiles = {
			"myappliances_hotwater_tank.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_hotwater_tank.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
		selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
			}
		},

})
--Furnace
core.register_node("myappliances:furnace", {
	description = "Furnace",
	tiles = {
			"myappliances_furnace.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_furnace.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
})

--Stove_pipe
core.register_node("myappliances:stove_pipe", {
	description = "Stove Pipe",
	tiles = {"myappliances_hotwater_heater_sides.png"},
	drawtype = "mesh",
	mesh = "myappliances_stove_pipe.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.25, -0.5, 0.25, 0.25, 0.5},
				},
			},
	on_place = core.rotate_node
})

--Stove_pipe Vertical
core.register_node("myappliances:stove_pipe_vert", {
	description = "Stove Pipe Vertical",
	tiles = {"myappliances_hotwater_heater_sides.png"},
	drawtype = "mesh",
	mesh = "myappliances_stove_pipe_vert.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
				},
			},
	on_place = core.rotate_node
})

--Stove Pipe Elbow
core.register_node("myappliances:stove_pipe_elbow", {
	description = "Stove Pipe Elbow",
	tiles = {"myappliances_hotwater_heater_sides.png"},
	drawtype = "mesh",
	mesh = "myappliances_stove_pipe_elbow.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.125, -0.5, 0.25, 0.125, 0.125},
			{-0.1875, -0.1875, -0.5, 0.1875, 0.1875, 0.125},
			{-0.125, -0.25, -0.5, 0.125, 0.25, 0.0625},
			{-0.125, -0.5, -0.25, 0.125, 0.0625, 0.25},
			{-0.1875, -0.5, -0.1875, 0.1875, 0.125, 0.1875},
			{-0.25, -0.5, -0.125, 0.25, -0.0625, 0.125},
				},
			},
	on_place = core.rotate_node
})
core.register_craft({
    output = "myappliances:stove_pipe 3",
    recipe = {
        {"mypress:sheet_steel", "mypress:sheet_steel", "mypress:sheet_steel"},
        {"", "", ""},
        {"", "", ""}
    }
})
core.register_craft({
    output = "myappliances:stove_pipe_vert 3",
    recipe = {
        {"mypress:sheet_steel", "", ""},
        {"mypress:sheet_steel", "", ""},
        {"mypress:sheet_steel", "", ""}
    }
})
core.register_craft({
    output = "myappliances:stove_pipe_elbow 3",
    recipe = {
        {"mypress:sheet_steel", "mypress:sheet_steel", ""},
        {"mypress:sheet_steel", "", ""},
        {"", "", ""}
    }
})

