-- items eat

function register_food(name, def)
	minetest.register_craftitem(name, {
		wield_scale = {x = 1, y = 1, z = 3},
		description = def.desc,
		groups = {food = 1},
		inventory_image = def.inventory_image,
		stack_max = def.stack_max or 99,
		range = 0,
		_consumption_time = def.consumption_time, -- Этот параметр лучше ставить кратным LIMIT_TIME из effects
		_feed_hunger = def.feed_hunger,
	})
end

register_food("items_eat:bread", {
	desc = "Bread",
	inventory_image = "items_eat_bread.png",
	stack_max = 16,
	consumption_time = 2.0,
	feed_hunger = 2,
})

register_food("items_eat:red_berry", {
	desc = "Red berry",
	inventory_image = "items_eat_red_berry.png",
	stack_max = 32,
	consumption_time = 1,
	feed_hunger = 1,
})
