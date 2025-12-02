local shape = {}
local make_ok = {}

core.register_node("myappliances:machine_top", {
--	description = "Appliance Machine Top",
	tiles = {
		"myappliances_dishwasher_sides.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, 0.5},
			{0.375, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.25, -0.5, -0.375, -0.1875, 0.5, -0.3125},
			{0.1875, -0.5, -0.375, 0.25, 0.5, -0.3125},
			{0.1875, -0.5, 0.0625, 0.25, 0.5, 0.125},
			{-0.25, -0.5, 0.0625, -0.1875, 0.5, 0.125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		}
	},
})

core.register_node("myappliances:machine", {
	description = "Appliance Machine",
	tiles = {
		"myappliances_dishwasher_sides.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, 0.5},
			{0.375, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.25, -0.5, -0.375, -0.1875, 0.5, -0.3125},
			{0.1875, -0.5, -0.375, 0.25, 0.5, -0.3125},
			{0.1875, -0.5, 0.0625, 0.25, 0.5, 0.125},
			{-0.25, -0.5, 0.0625, -0.1875, 0.5, 0.125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
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
    
after_destruct = function(pos, oldnode)
		core.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	end,

after_place_node = function(pos, placer)

	core.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:machine_top", 		param2=core.dir_to_facedir(placer:get_look_dir())});

	local meta = core.get_meta(pos);
	meta:set_string("owner",  (placer:get_player_name() or ""));
	meta:set_string("infotext",  "Appliance Machine (owned by " .. (placer:get_player_name() or "") .. ")");
	
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
	return true
end,

can_dig = function(pos,player)
	local meta = core.get_meta(pos);
	local inv = meta:get_inventory()
	if player:get_player_name() == meta:get_string("owner") and
	inv:is_empty("plastic") and
	inv:is_empty("copper") and
	inv:is_empty("steel") and
	inv:is_empty("res") then
		return true
	else
	return false
	end
end,

on_construct = function(pos)
		
	local meta = core.get_meta(pos)
	meta:set_string("formspec", "size[10,11;]"..
		"background[-0.15,-0.25;10.40,11.75;myappliances_background.png]"..
		
		"label[1,4;Plastic]"..
		"list[current_name;plastic;1,5;1,1;]"..
		
		"label[2.25,4;Copper Wire]"..
		"list[current_name;copper;2.5,5;1,1;]"..
		
		"label[4,4;Steel Sheet]"..
		"list[current_name;steel;4,5;1,1;]"..
		
		"label[6,4;Output]"..
		"list[current_name;res;6,5;1,1;]"..
		
		
		"label[1,1;Pick Your Appliance]"..
		--row 1
		--row 4
		"image_button[1,1.5;1,1;myappliances_mach19.png;furn19; ]"..
		"image_button[2,1.5;1,1;myappliances_mach20.png;furn20; ]"..
		"image_button[3,1.5;1,1;myappliances_mach18.png;furn18; ]"..
		"image_button[4,1.5;1,1;myappliances_mach21.png;furn21; ]"..
		"image_button[5,1.5;1,1;myappliances_mach22.png;furn22; ]"..
		"image_button[6,1.5;1,1;myappliances_mach23.png;furn23; ]"..
		"image_button[7,1.5;1,1;myappliances_mach24.png;furn24; ]"..
		"image_button[8,1.5;1,1;myappliances_mach25.png;furn25; ]"..
		"image_button[1,2.5;1,1;myappliances_mach26.png;furn26; ]"..
		"image_button[2,2.5;1,1;myappliances_mach27.png;furn27; ]"..
		"image_button[3,2.5;1,1;myappliances_mach28.png;furn28; ]"..
		"image_button[4,2.5;1,1;myappliances_mach29.png;furn29; ]"..
		"image_button[5,2.5;1,1;myappliances_mach30.png;furn30; ]"..
		"image_button[6,2.5;1,1;myappliances_mach31.png;furn31; ]"..
		"image_button[7,2.5;1,1;myappliances_mach32.png;furn32; ]"..
		"image_button[8,2.5;1,1;myappliances_mach33.png;furn33; ]"..

		"list[current_player;main;1,7;8,4;]")
	meta:set_string("infotext", "Appliance Machine")
	local inv = meta:get_inventory()
	inv:set_size("plastic", 1)
	inv:set_size("copper", 1)
	inv:set_size("steel", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()

if fields["furn18"]
or fields["furn19"]
or fields["furn20"]
or fields["furn21"]
or fields["furn22"]
or fields["furn23"]
or fields["furn24"]
or fields["furn25"]
or fields["furn26"]
or fields["furn27"]
or fields["furn28"]
or fields["furn29"]
or fields["furn30"]
or fields["furn31"]
or fields["furn32"]
or fields["furn33"]
then

	if fields["furn18"] then
		make_ok = "0"
		shape = "myappliances:fridge"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn19"] then
		make_ok = "0"
		shape = "myappliances:stove"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn20"] then
		make_ok = "0"
		shape = "myappliances:dishwasher"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn21"] then
		make_ok = "0"
		shape = "myappliances:freezer"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn22"] then
		make_ok = "0"
		shape = "myappliances:tv"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn23"] then
		make_ok = "0"
		shape = "myappliances:tv_w_stand"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn24"] then
		make_ok = "0"
		shape = "myappliances:stereo"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn25"] then
		make_ok = "0"
		shape = "myappliances:speaker"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn26"] then
		make_ok = "0"
		shape = "myappliances:computer"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn27"] then
		make_ok = "0"
		shape = "myappliances:washer"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn28"] then
		make_ok = "0"
		shape = "myappliances:dryer"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn29"] then
		make_ok = "0"
		shape = "myappliances:microwave"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn30"] then
		make_ok = "0"
		shape = "myappliances:watercooler"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn31"] then
		make_ok = "0"
		shape = "myappliances:coffeemaker"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn32"] then
		make_ok = "0"
		shape = "myappliances:airfryer"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

	if fields["furn33"] then
		make_ok = "0"
		shape = "myappliances:toaster"
		if inv:is_empty("plastic") or
		   inv:is_empty("copper") or
		   inv:is_empty("steel") then
			return
		end
	end

		local stack1 = inv:get_stack("plastic", 1)
		local stack2 = inv:get_stack("copper", 1)
		local stack3 = inv:get_stack("steel", 1)
		local resstack = inv:get_stack("res", 1)


------------------------------------------------------------------------------------------
--register nodes here
------------------------------------------------------------------------------------------
		if stack1:get_name()=="mystreets:plastic" and
		stack2:get_name()=="mypress:copper_wire" and
		stack3:get_name()=="mypress:sheet_steel" then
				make_ok = "1"
		end

----------------------------------------------------------------------------
    		if make_ok == "1" then
				inv:add_item("res",shape)
				stack1:take_item()
				stack2:take_item()
				stack3:take_item()
				inv:set_stack("plastic",1,stack1)
				inv:set_stack("copper",1,stack2)
				inv:set_stack("steel",1,stack3)
				make_ok = 0
			end            
   

end	
end,
})

--Craft

core.register_craft({
		output = 'myappliances:machine',
		recipe = {
			{'mypress:sheet_tin', '', 'mypress:sheet_tin'},
			{'mypress:sheet_tin', 'mypress:copper_wire', 'mypress:sheet_tin'},
			{'mypress:sheet_tin', "mypress:sheet_tin", 'mypress:sheet_tin'},		
		},
})













