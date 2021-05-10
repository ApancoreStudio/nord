main = {}

minetest.register_node("main:stone", {
	description = "Stone",
	tiles = {"main_basalt.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("main:cumen", {
	description = "Cumen",
	tiles = {"main_cumen.png"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("main:chernozem", {
	description = "Chernozem",
	tiles = {"main_chernozem.png"},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1}
})

minetest.register_node("main:turf", {
	description = "Turf",
	tiles = {"main_turf.png", "main_chernozem.png",
	{name = "main_chernozem.png^main_turf_side.png", tileable_vertical = false}},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1}
})

minetest.register_node("main:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "main_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "main_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	--use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "main:water_flowing",
	liquid_alternative_source = "main:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
})

minetest.register_node("main:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"main_water.png"},
	special_tiles = {
		{
			name = "main_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "main_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	--use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "main:water_flowing",
	liquid_alternative_source = "main:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
})

minetest.register_alias("mapgen_stone", "main:stone")
minetest.register_alias("mapgen_water_source", "main:water_source")

minetest.register_biome({
    name = "basic2",
	node_dust = "main:turf",
    node_top = "main:chernozem",
	depth_top = 4,
	node_filler = "main:stone",
	depth_filler = 1,
    node_cave_liquid = "main:water_source",
    y_max = 360,
    y_min = -64,
    heat_point = 50,
    humidity_point = 35,
})

minetest.register_biome({
    name = "basic",
    node_top = "main:cumen",
	depth_top = 1,
    node_cave_liquid = "main:water_source",
    y_max = 64,
    y_min = -64,
    heat_point = 51,
    humidity_point = 16,
})
