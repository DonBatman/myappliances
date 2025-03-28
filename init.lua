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
	drawtype = "normal",
	inventory_image = "myappliances_fridge_inv.png",
	wield_image = "myappliances_fridge_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
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
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
after_destruct = function(pos, oldnode)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
	end,
})
