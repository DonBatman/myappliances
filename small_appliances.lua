--Toaster
core.register_node("myappliances:toaster", {
	description = "Toaster",
	tiles = {
			"myappliances_toaster.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_toaster.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.25, 0.1875, 0, 0.3125},
		}
	}
})
--Air Fryer
core.register_node("myappliances:airfryer", {
	description = "Air Fryer",
	tiles = {
			"myappliances_airfryer.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_airfryer.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.1, 0.5},
		}
	}
})
--Coffee Maker
core.register_node("myappliances:coffeemaker", {
	description = "Coffee Maker",
	tiles = {
			"myappliances_coffeemaker.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_coffeemaker.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, 0, 0.1875, 0, 0.5},
		}
	}
})
--Microwave
core.register_node("myappliances:microwave", {
	description = "Microwave",
	tiles = {
			"myappliances_microwave.png",
			},
	drawtype = "mesh",
	mesh = "myappliances_microwave.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 0},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.25, 0.5, 0.1875, 0.3125},
		}
	}
})
