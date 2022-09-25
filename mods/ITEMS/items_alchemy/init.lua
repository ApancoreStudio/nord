-- items alchemy

local bonfire_nodebox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
}

local function give_cooking_result(result, pos, entity)
	entity:remove()
	minetest.add_item(pos, result)
end

local function campfire_cooking(pos, node, clicker, itemstack, pointed_thing)
	local itemstack_name = itemstack:get_name()

	if not items_eat.campfire_cooking_items[itemstack_name] then return end

	itemstack:take_item(1)
	pos.y = pos.y+0.3

	local entity = minetest.add_entity(pos, "items_alchemy:bonfire_item_cooking")

	local prop = entity:get_properties()
	prop.textures = {itemstack_name}
	entity:set_properties(prop)

	minetest.after(
		items_eat.campfire_cooking_items[itemstack_name][2],
		give_cooking_result,
		items_eat.campfire_cooking_items[itemstack_name][1],
		pos,
		entity
	)
end

minetest.register_node("items_alchemy:bonfire", {
	description = "Bonfire",
	visual_scale = 0.5,
	mesh = "bonfire.obj",
	tiles = {"bonfire_long_log.png", "bonfire_bedding.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 3,},
	drawtype = "mesh",
	paramtype = "light",
	light_source = 14,
	paramtype2 = "facedir",
	damage_per_second = 4,
	selection_box = bonfire_nodebox,
	collision_box = bonfire_nodebox,
	on_rightclick = campfire_cooking,
})

minetest.register_abm({
	label = "Fire on bonfire",
	nodenames = {"items_alchemy:bonfire"},
	interval = 0.1,
	chance = 1,
	min_y = -32768,
    max_y = 32767,
	action = function(pos)
		for i = 1, math.random(5, 8) do
			local par_pos = {
				x = pos.x + math.random(-3, 3)/10,
				y = pos.y + 0.1,
				z = pos.z + math.random(-3, 3)/10,
			}
			minetest.add_particle({
				pos = par_pos,
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = math.random(10, 30)/10,
				size = math.random(1, 10)/2,
				texture = "bonfire_fire.png",
				glow = 10
			})
		end
	end,
})

minetest.register_entity("items_alchemy:bonfire_item_cooking", {
	visual = "wielditem",
	use_texture_alpha = true,
	collide_with_objects = false,
	physical = false,
	pointable = false,
	visual_size = {x = 0.3, y = 0.3, z = 0.3},
	textures = {""},
})

minetest.register_craft({
	output = "items_alchemy:bonfire",
	recipe = {
		{"","",""},
		{"","items_stone:flint",""},
		{"group:log","group:log","group:log"},
	}
})

local function register_ingot(material, def)
	local name = "items_alchemy:"..material.."_ingot"
	local image = "items_alchemy_"..material.."_ingot.png"
	local groups = def["groups"]
	groups["ingot"] = 1
	minetest.register_craftitem(name, {
		description = def.desc,
		groups = groups,
		inventory_image = image,
		wield_image = image,
		stack_max = 8,
	})
end

local ingots_material = {
	"bronze",
}

local ingots_def = {
	["bronze"] = {
		desc = "Bronze ingot",
		groups = {bronze = 1},
	},
}

for _, material in ipairs(ingots_material) do
	register_ingot(material, ingots_def[material])
end
