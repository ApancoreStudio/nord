-- items eat

items_eat = {}

-- [имя] = {результат, время готовки}
items_eat.campfire_cooking_items = {
	["items_eat:beef"] = {"items_eat:beef_fried", 10}
}

local function register_food(name, def)
	minetest.register_craftitem(name, {
		description = def.desc,
		groups = {food = 1},
		inventory_image = def.inventory_image,
		--stack_max = def.stack_max or 99,
		range = 3,
		_consumption_time = def.consumption_time,
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

register_food("items_eat:beef", {
	desc = "Beef",
	inventory_image = "items_eat_beef.png",
	stack_max = 16,
	consumption_time = 3,
	feed_hunger = 2,
})

register_food("items_eat:beef_fried", {
	desc = "Fried beef",
	inventory_image = "items_eat_beef_fried.png",
	stack_max = 16,
	consumption_time = 3,
	feed_hunger = 6,
})
