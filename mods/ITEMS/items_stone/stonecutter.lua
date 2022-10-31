-- Камнетёс
local nodebox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
}

minetest.register_node("items_stone:stonecutter", {
	description = "Stonecutter",
	--visual_scale = {0.1, 0.1, 0.1},
	mesh = "items_stone_stonecutter.obj",
	backface_culling = true,
	tiles = {"items_stone_stonecutter_top.png",
		"items_stone_stonecutter_side.png",
		"items_stone_stonecutter_under.png",
		"items_stone_stonecutter_side.png",
		"items_stone_basalt.png"},
	collision_box = nodebox,
	selection_box = nodebox,
	groups = {cracky = 3},
	drawtype = "mesh",
	paramtype2 = "facedir",
	paramtype = "light",
})

minetest.register_alias("stonecutter", "items_stone:stonecutter")

