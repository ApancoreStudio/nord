-- items_plants

minetest.register_node("items_plants:roses", {
	drawtype = "plantlike",
	description = "Roses",
	tiles = {"items_plants_roses.png"},
	groups = {plants = 1, snappy=3, attached_node=1},
	paramtype2 = "meshoptions",
	place_param2 = 2,
	waving = 1,
	walkable = false,
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
