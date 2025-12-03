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
			"myappliances_stove.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_stove.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	}
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.5},
		},
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, 0.375, 0.5},
		},
	}
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0.375, 0.15},
		},
	}
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0, 0.375},
		},
	},
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

--Floor Speakers
core.register_node("myappliances:floorspeakers", {
	description = "Computer",
	tiles = {
			"myappliances_floorspeaker.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_floorspeaker.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	
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
			"myappliances_watercooler.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_watercooler.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},

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
	groups = {cracky = 2, oddly_breakable_by_hand = 2},

	selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.125, 0.375, 0.5, 0.375},
		}
	},
})
