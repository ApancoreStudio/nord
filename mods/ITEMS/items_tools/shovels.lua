-- tools shovels

tools.shovel = {
	get_recipes = function(source)
		return {{
			{source},
			{'group:stick'},
			{'group:stick'},
		}}
	end,
	wood = {
		description = "Wooden Shovel",
		wield_image_transform = "^[transformR90",
		full_punch_interval = 1.2,
		max_drop_level = 0,
		crumbly = {
			times={[1]=3.00, [2]=1.60, [3]=0.60},
			uses=10,
			maxlevel=1
		},
		damage_groups = {fleshy=2},
		groups = {wooden = 1, shovel = 1},
	},
	flint = {
		description = "Flint Shovel",
		wield_image_transform = "^[transformR90",
		full_punch_interval = 1.4,
		max_drop_level = 0,
		crumbly = {
			times={[1]=1.80, [2]=1.20, [3]=0.50},
			uses=20,
			maxlevel=1
		},
		damage_groups = {fleshy=2},
		groups = {shovel = 1},
	},
}
