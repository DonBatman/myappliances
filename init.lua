dofile(core.get_modpath("myappliances").."/machine.lua")
dofile(core.get_modpath("myappliances").."/small_appliances.lua")

--Dishwasher
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
})
--Stove
core.register_node("myappliances:stove", {
	description = "Stove",
	tiles = {
			"myappliances_stove_top.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_stove_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		}
	}
})
--Fridge
core.register_node("myappliances:fridge", {
	description = "Fridge",
	tiles = {
			"myappliances_fridge_side.png^[transformR270",
			"myappliances_dishwasher_sides.png",
			"myappliances_fridge_side.png^[transformR180",
			"myappliances_fridge_side.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_fridge_front.png",
			},
	drawtype = "nodebox",
	inventory_image = "myappliances_fridge_inv.png",
	wield_image = "myappliances_fridge_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
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
	core.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:fridge_top", 		param2=core.dir_to_facedir(placer:get_look_dir())});

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

})
--Fridge Top
core.register_node("myappliances:fridge_top", {
--	description = "Fridge",
	tiles = {
			"myappliances_fridge_side.png^[transformR270",
			"myappliances_dishwasher_sides.png",
			"myappliances_fridge_side.png^[transformR180",
			"myappliances_fridge_side.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_fridge_front.png^[transformFY",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
		},
})

--Freezer
core.register_node("myappliances:freezer", {
	description = "Freezer",
	tiles = {
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_freezer_side.png",
			"myappliances_freezer_side.png",
			"myappliances_freezer_side.png",
			"myappliances_freezer_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.5},
		},
})
--TV
core.register_node("myappliances:tv", {
	description = "TV",
	tiles = {
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, 0.4375, 0.375, 0.25, 0.5},
			{-0.5, -0.375, 0.375, 0.5, 0.375, 0.4375},
		},
	}
})
--TV w Stand
core.register_node("myappliances:tv_w_stand", {
	description = "TV With Stand",
	tiles = {
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, 0.4375, 0.375, 0.25, 0.5},
			{-0.5, -0.375, 0.375, 0.5, 0.375, 0.4375},
			{-0.25, -0.5, 0.375, 0.25, -0.375, 0.5},
			{-0.3125, -0.5, 0.3125, 0.3125, -0.4375, 0.5},
		},
	}
})
--Stereo
core.register_node("myappliances:stereo", {
	description = "Stereo",
	tiles = {
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_stereo_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.25, 0.375, 0.5, 0.5},
		},
	}
})
--Speakers
core.register_node("myappliances:speaker", {
	description = "Speaker",
	tiles = {
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_speaker_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.0625, 0.3125, 0.3125, 0.5},
		},
	}
})
--Speakers
core.register_node("myappliances:computer", {
	description = "Computer",
	tiles = {
			"myappliances_computer_top.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_tv_side.png",
			"myappliances_computer_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.375, 0.4375, 0.3125, 0.1875, 0.5},
			{-0.375, -0.375, 0.375, 0.375, 0.25, 0.4375},
			{-0.125, -0.5, 0.375, 0.125, -0.375, 0.5},
			{-0.1875, -0.5, 0.3125, 0.1875, -0.4375, 0.5},
			{-0.3125, -0.5, -0.0625, 0.125, -0.4375, 0.125},
			{0.1875, -0.5, -0.0625, 0.3125, -0.4375, 0.125},
		},
	}
})

--Washer
core.register_node("myappliances:washer", {
	description = "Washer",
	tiles = {
			"myappliances_washer_top.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_washer_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		},
	}
})
--Dryer
core.register_node("myappliances:dryer", {
	description = "Dryer",
	tiles = {
			"myappliances_dryer_top.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dryer_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		},
	}
})

--Water Cooler
core.register_node("myappliances:watercooler", {
	description = "Water Cooler",
	tiles = {
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			},
	drawtype = "nodebox",
	inventory_image = "myappliances_water_cooler_inv.png",
	wield_image = "myappliances_water_cooler_wield.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
			{-0.3125, -0.5, -0.1875, 0.3125, 0.5, 0.4375},
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.5},
			{-0.0625, 0.25, -0.4375, 0.0625, 0.375, -0.25},
			{-0.125, -0.125, -0.5, 0.125, 0, -0.25},
			}
		},
		selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
			{-0.3125, -0.5, -0.1875, 0.3125, 0.5, 0.4375},
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.5},
			{-0.0625, 0.25, -0.4375, 0.0625, 0.375, -0.25},
			{-0.125, -0.125, -0.5, 0.125, 0, -0.25},
			{-0.3125, -0.5, -0.0625, 0.3125, 1.3125, 0.3125},
			{-0.25, -0.5, -0.125, 0.25, 1.3125, 0.375},
			{-0.1875, -0.5, -0.1875, 0.1875, 1.3125, 0.4375},
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
	core.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:watercoolertop", 		param2=core.dir_to_facedir(placer:get_look_dir())});

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

})
--Water Cooler Top
core.register_node("myappliances:watercoolertop", {
--	description = "Water Cooler",
	tiles = {
			"myappliances_water_cooler_front.png",
			"myappliances_water_cooler_front.png",
			"myappliances_water_cooler_front.png",
			"myappliances_water_cooler_front.png",
			"myappliances_water_cooler_front.png",
			"myappliances_water_cooler_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.0625, 0.3125, 0.3125, 0.3125},
			{-0.25, -0.5, -0.125, 0.25, 0.3125, 0.375},
			{-0.1875, -0.5, -0.1875, 0.1875, 0.3125, 0.4375},
			}
		},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
		},
})
