-- Entities mobs

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/mobs_api.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/ways_of_thinking.lua")

entities_mobs.register_mob("entities_mobs:bread", {
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5,},
	visual_size = {x = 10, y = 10, z = 10},
	mesh = "bonfire.obj",
	textures = {"items_eat_bread.png"},
	max_hp = 1,
	review = 5,
	way_of_thinking = "standart",
})
