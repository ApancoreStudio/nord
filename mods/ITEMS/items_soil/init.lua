-- items soil

minetest.register_node("items_soil:chernozem", {
	description = "Chernozem",
	tiles = {"items_soil_chernozem.png", "items_soil_chernozem.png", "items_soil_chernozem_side.png"},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1, soil = 1}
})

minetest.register_node("items_soil:silt", {
	description = "Silt",
	tiles = {"items_soil_silt.png"},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1, soil = 1, falling_node = 1}
})

minetest.register_node("items_soil:sand", {
	description = "Sand",
	tiles = {"items_soil_sand.png"},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1, soil = 1, falling_node = 1}
})

minetest.register_node("items_soil:meadow_turf", {
	description = "Meadow turf",
	tiles = {"items_soil_meadow_turf.png", "items_soil_chernozem.png",
	{name = "items_soil_chernozem_side.png^items_soil_meadow_turf_side.png", tileable_vertical = false}},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1, soil = 1}
})

minetest.register_node("items_soil:forest_turf", {
	description = "Forest turf",
	tiles = {"items_soil_forest_turf.png", "main_chernozem.png",
	{name = "main_chernozem.png^items_soil_forest_turf_side.png", tileable_vertical = false}},
	groups = {crumbly = 3, oddly_breakable_by_hand = 1, soil = 1}
})
