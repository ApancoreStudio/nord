-- tools picks

items_tools.pick = {
	get_craft_recipes = function(material)
		return {{
			{material, material, material},
			{'', 'group:stick', ''},
			{'', 'group:stick', ''},
		}}
	end,
	flint = {
		desc = "Flint Pickaxe",
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

	obsidian = {
		desc = "Obsidian Pickaxe",
		full_punch_interval = 1,
		max_drop_level = 2,
		cracky = {
			times={[1] =1.5, [2]=1, [3]=0.6},
			uses=50,
			maxlevel=1
		},
		damage_groups = {fleshy = 4},
		groups = {pickaxe = 1},
	},
}
