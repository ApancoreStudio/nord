-- items stone

minetest.register_node("items_stone:basalt", {
	description = "Basalt",
	tiles = {"main_basalt.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("items_stone:granite", {
	description = "Granite",
	tiles = {"items_stone_granite.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("items_stone:limestone", {
	description = "Limestone",
	tiles = {"items_stone_limestone.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("items_stone:limestone_bricks", {
	description = "Limestone bricks",
	tiles = {"items_stone_limestone_bricks.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("items_stone:glowstone", {
	description = "Glowstone",
	tiles = {"items_stone_glowstone.png"},
	groups = {cracky = 3, stone = 1, light = 1},
	paramtype = "light",
	light_source = 14,
	})
