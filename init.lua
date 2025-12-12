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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
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
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},
	
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0, 0.375},
		},
	},
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

