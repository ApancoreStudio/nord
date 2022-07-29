-- items equipment

minetest.register_craftitem("items_equipment:hipbag", {
	description = "Hipbag",
	inventory_image = "items_equipment_hipbag.png",
	groups = {equipment = 1, hipbag = 2},
	stack_max = 1
})

minetest.register_craftitem("items_equipment:big_hipbag", {
	description = "Big hipbag",
	inventory_image = "items_equipment_big_hipbag.png",
	groups = {equipment = 1, hipbag = 3},
	stack_max = 1
})
