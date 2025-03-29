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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
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
minetest.register_node("myappliances:fridge", {
	description = "Fridge",
	tiles = {
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
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
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
			"myappliances_dishwasher_sides.png",
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
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
minetest.register_node("myappliances:dryer", {
	description = "Dryer",
	tiles = {
			"myappliances_dishwasher_sides.png",
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
