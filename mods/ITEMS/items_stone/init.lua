-- items stone

minetest.register_node("items_stone:basalt", {
	description = "Basalt",
	tiles = {"items_stone_basalt.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_alias("basalt", "items_stone:basalt")

minetest.register_node("items_stone:basalt_block", {
	description = "Basalt block",
	tiles = {"items_stone_basalt_block.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_alias("basalt_block", "items_stone:basalt_block")

minetest.register_node("items_stone:basalt_block_glow", {
	description = "Basalt block glow",
	tiles = {"items_stone_basalt_block_glow.png"},
	groups = {cracky = 3, stone = 1, light = 1},
	paramtype = "light",
	light_source = 14,
})

minetest.register_alias("basalt_block_glow", "items_stone:basalt_block_glow")

minetest.register_node("items_stone:magma", {
	description = "Magma",
	tiles = {"items_stone_magma.png"},
	groups = {cracky = 3, stone = 1},
})

minetest.register_alias("magma", "items_stone:magma")

minetest.register_node("items_stone:magma_with_diamond", {
	description = "Magma With Diamond",
	tiles = {"items_stone_magma_with_diamond.png"},
	groups = {cracky = 3, stone = 1},
	paramtype = "ligh",
	light_source = 14,
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

minetest.register_node("items_stone:kharite", {
	description = "Kharite",
	tiles = {"items_stone_kharite.png"},
	groups = {cracky = 3, stone = 1} -- Потом исправить группу
})

minetest.register_node("items_stone:glowstone", {
	description = "Glowstone",
	tiles = {"items_stone_glowstone.png"},
	groups = {cracky = 3, stone = 1, light = 1},
	paramtype = "light",
	light_source = 15,
})

minetest.register_alias("glowstone", "items_stone:glowstone")

minetest.register_craftitem("items_stone:flint", {
	description = "Flint",
	inventory_image = "items_stone_flint.png",
	groups = {flint = 1},
})
