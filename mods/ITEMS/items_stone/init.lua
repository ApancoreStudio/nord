-- items stone

minetest.register_node("items_stone:basalt", {
	description = "Basalt",
	tiles = {"items_stone_basalt.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_alias("basalt", "items_stone:basalt")

minetest.register_node("items_stone:basalt_block", {
	description = "Basalt Block",
	tiles = {"items_stone_basalt_block.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_alias("basalt_block", "items_stone:basalt_block")

minetest.register_node("items_stone:basalt_block_glow", {
	description = "Basalt Block Glow",
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
	tiles = {"items_stone_magma.png^items_stone_diamond_ore.png"},
	drop = "items_stone:diamond",
	groups = {cracky = 3, stone = 1},
})

minetest.register_craftitem("items_stone:diamond", {
	description = "Diamond",
	inventory_image = "items_stone_diamond.png",
	groups = {gem = 1},
})

minetest.register_alias("diamond", "items_stone:diamond")

minetest.register_node("items_stone:diamond_block", {
	description = "Diamond block",
	tiles = {"items_stone_diamond_block.png"},
	groups = {cracky = 3, stone = 1, gem = 1},
})

minetest.register_alias("diamond_block", "items_stone:diamond_block")

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
	description = "Limestone Bricks",
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

-- ores
-- gold
minetest.register_node("items_stone:basalt_with_gold", {
	description = "Basalt With Gold",
	tiles = {"items_stone_basalt.png^items_stone_gold_ore.png"},
	drop = "items_stone:gold_lump",
	groups = {cracky = 3, stone = 1, gold = 1}
})

minetest.register_alias("basalt_with_gold", "items_stone:basalt_with_gold")

minetest.register_craftitem("items_stone:gold_lump", {
	description = "Gold Lump",
	inventory_image = "items_stone_gold_lump.png",
	groups = {gold = 1},
})

minetest.register_alias("gold_lump", "items_stone:gold_lump")

-- coal
minetest.register_node("items_stone:basalt_with_coal", {
	description = "Basalt With Coal",
	tiles = {"items_stone_basalt.png^items_stone_coal_ore.png"},
	drop = "items_stone:coal_lump",
	groups = {cracky = 3, stone = 1, coal = 1}
})

minetest.register_alias("basalt_with_coal", "items_stone:basalt_with_coal")

minetest.register_craftitem("items_stone:coal_lump", {
	description = "Coal Lump",
	inventory_image = "items_stone_coal_lump.png",
	groups = {coal = 1},
})

minetest.register_alias("coal_lump", "items_stone:coal_lump")

-- copper
minetest.register_node("items_stone:basalt_with_copper", {
	description = "Basalt With Copper",
	tiles = {"items_stone_basalt.png^items_stone_copper_ore.png"},
	drop = "items_stone:copper_lump",
	groups = {cracky = 3, stone = 1, copper = 1}
})

minetest.register_alias("basalt_with_copper", "items_stone:basalt_with_copper")

minetest.register_craftitem("items_stone:copper_lump", {
	description = "Copper Lump",
	inventory_image = "items_stone_copper_lump.png",
	groups = {copper = 1},
})

minetest.register_alias("copper_lump", "items_stone:copper_lump")

-- tin
minetest.register_node("items_stone:basalt_with_tin", {
	description = "Basalt With Tin",
	tiles = {"items_stone_basalt.png^items_stone_tin_ore.png"},
	drop = "items_stone:tin_lump",
	groups = {cracky = 3, stone = 1, tin = 1}
})

minetest.register_alias("basalt_with_tin", "items_stone:basalt_with_tin")

minetest.register_craftitem("items_stone:tin_lump", {
	description = "Tin Lump",
	inventory_image = "items_stone_tin_lump.png",
	groups = {tin = 1},
})

minetest.register_alias("tin_lump", "items_stone:tin_lump")

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/stonecutter.lua")
