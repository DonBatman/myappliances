dofile(minetest.get_modpath("myappliances").."/machine.lua")

--Dishwasher
minetest.register_node("myappliances:dishwasher", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
})
--Stove
minetest.register_node("myappliances:stove", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		}
	}
})
--Fridge
minetest.register_node("myappliances:fridge", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

after_destruct = function(pos, oldnode)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	end,

after_place_node = function(pos, placer)
	minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:fridge_top", 		param2=minetest.dir_to_facedir(placer:get_look_dir())});

	end,

can_dig = function(pos,player)

	local meta = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,

})
--Fridge Top
minetest.register_node("myappliances:fridge_top", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
minetest.register_node("myappliances:freezer", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.5},
		},
})
--TV
minetest.register_node("myappliances:tv", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, 0.4375, 0.375, 0.25, 0.5},
			{-0.5, -0.375, 0.375, 0.5, 0.375, 0.4375},
		},
	}
})
--TV w Stand
minetest.register_node("myappliances:tv_w_stand", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
minetest.register_node("myappliances:stereo", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.25, 0.375, 0.5, 0.5},
		},
	}
})
--Speakers
minetest.register_node("myappliances:speaker", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.0625, 0.3125, 0.3125, 0.5},
		},
	}
})
--Speakers
minetest.register_node("myappliances:computer", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
minetest.register_node("myappliances:washer", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		},
	}
})
--Dryer
minetest.register_node("myappliances:dryer", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
		},
	}
})
--Microwave
minetest.register_node("myappliances:microwave", {
	description = "Microwave",
	tiles = {
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_microwave_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.125, 0.5},
			{0.125, -0.375, -0.1875, 0.1875, 0, -0.125},
		},
	}
})

--Water Cooler
minetest.register_node("myappliances:watercooler", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

after_destruct = function(pos, oldnode)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	end,

after_place_node = function(pos, placer)
	minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:watercoolertop", 		param2=minetest.dir_to_facedir(placer:get_look_dir())});

	end,

can_dig = function(pos,player)

	local meta = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,

})
--Water Cooler Top
minetest.register_node("myappliances:watercoolertop", {
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
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
--Hotwater Heater
minetest.register_node("myappliances:hotwater_heater", {
	description = "Hotwater Heater",
	tiles = {
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_bottom_front.png",
			},
	drawtype = "nodebox",
	inventory_image = "myappliances_hotwater_heater_inv.png",
	wield_image = "myappliances_hotwater_heater_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.5, 0.25, 0.5, 0.5},
			{-0.3125, -0.5, -0.4375, 0.3125, 0.5, 0.4375},
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
			{-0.4375, -0.5, -0.3125, 0.4375, 0.5, 0.3125},
			{-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
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
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

after_destruct = function(pos, oldnode)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	end,

after_place_node = function(pos, placer)
	minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:hotwater_heater_top", 		param2=minetest.dir_to_facedir(placer:get_look_dir())});

	end,

can_dig = function(pos,player)

	local meta = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,

})
--Hotwater Heater  Top
minetest.register_node("myappliances:hotwater_heater_top", {
--	description = "Hotwater Heater",
	tiles = {
			"myappliances_hotwater_heater_top.png",
			"myappliances_hotwater_heater_sides.png",
			"myappliances_hotwater_heater_top_sides.png",
			"myappliances_hotwater_heater_top_sides.png",
			"myappliances_hotwater_heater_top_sides.png",
			"myappliances_hotwater_heater_top_front.png",
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.5, 0.25, 0.5, 0.5},
			{-0.3125, -0.5, -0.4375, 0.3125, 0.5, 0.4375},
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
			{-0.4375, -0.5, -0.3125, 0.4375, 0.5, 0.3125},
			{-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
			}
		},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
		},
})
--Furnace
minetest.register_node("myappliances:furnace", {
	description = "Furnace",
	tiles = {
			"myappliances_furnace_sides.png",
			"myappliances_furnace_sides.png",
			"myappliances_furnace_side.png^[transformR180",
			"myappliances_furnace_side.png",
			"myappliances_furnace_sides.png",
			"myappliances_furnace_front.png",
			},
	drawtype = "normal",
	inventory_image = "myappliances_furnace_inv.png",
	wield_image = "myappliances_furnace_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
			}
		},
on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

after_destruct = function(pos, oldnode)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	end,

after_place_node = function(pos, placer)
	minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myappliances:furnace_top", 		param2=minetest.dir_to_facedir(placer:get_look_dir())});

	end,

can_dig = function(pos,player)

	local meta = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,

})
--Furnace Top
minetest.register_node("myappliances:furnace_top", {
--	description = "Furnace",
	tiles = {
			"myappliances_furnace_side.png^[transformR270",
			"myappliances_furnace_sides.png",
			"myappliances_furnace_side.png^[transformR180",
			"myappliances_furnace_side.png",
			"myappliances_furnace_sides.png",
			"myappliances_furnace_front.png^[transformR180",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
		},
})

--Stove_pipe
minetest.register_node("myappliances:stove_pipe", {
	description = "Stove Pipe",
	tiles = {"myappliances_hotwater_heater_sides.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.125, -0.5, 0.25, 0.125, 0.5},
			{-0.1875, -0.1875, -0.5, 0.1875, 0.1875, 0.5},
			{-0.125, -0.25, -0.5, 0.125, 0.25, 0.5},
				},
			},
	on_place = minetest.rotate_node
})

--Stove Pipe Elbow
minetest.register_node("myappliances:stove_pipe_elbow", {
	description = "Stove Pipe Elbow",
	tiles = {"myappliances_hotwater_heater_sides.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	node_box = {
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
	on_place = minetest.rotate_node
})
