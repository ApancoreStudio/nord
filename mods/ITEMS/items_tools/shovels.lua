-- tools shovels

items_tools.shovel = {
	get_craft_recipes = function(source)
		return {{
			{source},
			{'group:stick'},
			{'group:stick'},
		}}
	end,
	flint = {
		desc = "Flint Shovel",
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
