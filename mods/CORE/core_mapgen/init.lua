-- core_mapgen

-- Алиасы
minetest.register_alias("mapgen_stone", "main:stone")
minetest.register_alias("mapgen_water_source", "items_liquid:water_source")

minetest.register_chatcommand("mapgen_climat", {
	description = "Определяет температуру и влажность для блока на месте игрока",
	func = function(name, param)
		player = minetest.get_player_by_name(name)
		local pos = player:get_pos()
		local hum = minetest.get_humidity(pos)
		local heat = minetest.get_heat(pos)

		minetest.chat_send_all("[#] Климат на позиции "..
		pos.x.." "..pos.y.." "..pos.z.."\n"..
		"Тепло: "..heat.."\n"..
		"Влажность: "..hum)
	end
})

minetest.register_ore({
	ore_type = "puff",
	ore = "items_stone:limestone",
	wherein = {"items_stone:granite", "items_soil:chernozem"},
	clust_scarcity = 4 * 6 * 4,
	clust_num_ores = 12,
	clust_size = 6,
	y_min = -24,
	y_max = 16,
	np_puff_top = {
		offset = 4,
		scale = 2,
		spread = {x = 100, y = 100, z = 100},
		seed = 47,
		octaves = 3,
		persistence = 0.7
    },
	np_puff_bottom = {
		offset = 4,
		scale = 2,
		spread = {x = 100, y = 100, z = 100},
		seed = 11,
		octaves = 3,
		persistence = 0.7
	},
})

-- Луга
minetest.register_biome({
	name = "meadow",

	node_top = "items_soil:meadow_turf",
	depth_top = 1,

	node_filler = "items_soil:chernozem",
	depth_filler = 4,

	node_stone = "items_stone:granite",

	node_river_water = "items_liquid:water_source",

	node_riverbed = "items_soil:silt",
    depth_riverbed = 2,

	y_max = 32,
	y_min = 3,

	vertical_blend = 0,

	heat_point = 70,
	humidity_point = 30,
})

-- Океан лугов
minetest.register_biome({
	name = "meadow_ocean",

	node_top = "items_soil:silt",
	depth_top = 3,

	node_stone = "items_stone:granite",

	node_water = "items_liquid:water_source",

	y_max = 0,
	y_min = -64,

	vertical_blend = 0,

	heat_point = 70,
	humidity_point = 30,
})

-- Пляж лугов
minetest.register_biome({
	name = "meadow_beach",

	node_top = "items_soil:sand",
	depth_top = 2,

	node_filler = "items_stone:granite",
	depth_filler = 2,

	node_stone = "items_stone:granite",

	y_max = 2,
	y_min = 0,

	vertical_blend = 0,

	heat_point = 70,
	humidity_point = 30,
})

-- Леса
minetest.register_biome({
	name = "forest",

	node_top = "items_soil:forest_turf",
	depth_top = 1,

	node_filler = "items_soil:chernozem",
	depth_filler = 3,

	node_stone = "items_stone:granite",

	node_river_water = "items_liquid:water_source",

	node_riverbed = "items_soil:silt",
    depth_riverbed = 4,

	y_max = 52,
	y_min = 3,

	vertical_blend = 0,

	heat_point = 30,
	humidity_point = 70,
})

minetest.register_biome({
	name = "Deep earth",

	node_stone = "items_stone:basalt",

	y_max = -150,
	y_min = -10000,

	vertical_blend = 2,
})

minetest.register_biome({
	name = "Magma earth",

	node_stone = "items_stone:magma",

	y_max = -10000,
	y_min = -20000,

	vertical_blend = 3,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "items_stone:magma_with_diamond",
	wherein = "items_stone:magma",
	clust_scarcity = 16*16*16,
	clust_num_ores = 12,
	clust_size = 6,
	y_max = -10000,
	y_min = -20000,
})

minetest.register_decoration({
	name = "core_mapgen:oak_bush",
	deco_type = "schematic",
	place_on = {"items_soil:meadow_turf"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"meadow"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("core_mapgen") .. "/schematics/oak_bush.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "core_mapgen:oak_tree",
	deco_type = "schematic",
	place_on = {"items_soil:forest_turf"},
	sidelen = 16,
	noise_params = {
		offset = 0.04,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("core_mapgen") .. "/schematics/oak_tree.mts",
	flags = "place_center_x, place_center_z",
})

