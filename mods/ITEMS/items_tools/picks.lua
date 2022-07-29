-- tools picks

tools.pick = {
	get_recipes = function(source)
		return {{
			{source, source, source},
			{'', 'group:stick', ''},
			{'', 'group:stick', ''},
		}}
	end,
	wood = {
		description = "Wooden Pickaxe",
		full_punch_interval = 1.2,
		max_drop_level = 0,
		cracky = {
			times={[3]=1.60},
			uses=10,
			maxlevel=1
		},
		damage_groups = {fleshy=2},
		groups = {wooden = 1, pickaxe = 1},
	},
	flint = {
		description = "Flint Pickaxe",
		full_punch_interval = 1.3,
		max_drop_level = 0,
		cracky = {
			times={[2]=2.0, [3]=1.20},
			uses=20,
			maxlevel=1
		},
		damage_groups = {fleshy = 3},
		groups = {pickaxe = 1},
	},
}
