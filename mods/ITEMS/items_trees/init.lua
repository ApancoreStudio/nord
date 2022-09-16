-- items trees
local modname = "items_trees"
--[[
tree - вид дерева
flags - таблица с флагами блоков

tree_def = {
	name - вид дерева

	flags = {
		[flag] = bool
		trunk - Ствол дерева при генерации
		log - Бревно, выпадает из ствола. Если trunk = true, тоже будет true
		planks - доски
		leaf - листва
		flower_leaf - цветущая листва
		stick - палка
	},

	hardness_trunk - крепкость дерева (1-3)
	hardness_planks - крепкость досок (1-3)
	oddly_breakable_by_hand - 0, если не копается (0-3)
}

Текстуры:
trunk & log:
	modname_tree_trunk_top.png
	modname_tree_trunk_side.png
planks:
	modname_tree_planks.png
leaf:
	modname_tree_leaf.png
stick:
	modname_tree_stick.png
flower_leaf:
	modname_tree_flower_leaf.png
fruit:
	modname_name_fruit.png
--]]

function register_tree_blocks(tree_def)
	local tree = tree_def.name
	local trunk_groups = {
		log = 1,
		wood = 1,
		choppy = tree_def.hardness_trunk,
		oddly_breakable_by_hand = tree_def.oddly_breakable_by_hand
	}
	local planks_groups = {
		wood = 1,
		planks = 1,
		choppy = tree_def.hardness_planks,
		oddly_breakable_by_hand = tree_def.oddly_breakable_by_hand
	}
	local leaf_groups = {
		leafs = 1,
		oddly_breakable_by_hand = 3,
	}
	local stick_groups = {stick = 1}

	local planks = modname..":"..tree.."_planks"
	local stick = modname..":"..tree.."_stick"
	local log_name = modname..":"..tree.."_log"
	
	
	-- trunk & log
	if tree_def.flags.trunk then
		-- trunk
		minetest.register_node(modname..":"..tree.."_trunk", {
			description = tree.." trunk",
			groups = trunk_groups,
			tiles = {
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_side.png"
			},
			drop = modname..":"..tree.."_log",
			-- Надо добавить on_place, чтобы установленный игроком ствол заменялся на бревно
		})
		-- log
		minetest.register_node(log_name, {
			description = tree.." log",
			groups = trunk_groups,
			tiles = {
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_side.png"
			},
		})
	end
	-- log, если trunk false
	if tree_def.flags.log and not tree_def.flags.trunk then
		minetest.register_node(log_name, {
			description = tree.." log",
			groups = trunk_groups,
			tiles = {
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_top.png",
				modname.."_"..tree.."_trunk_side.png"
			},
		})
	end
	-- planks
	if tree_def.flags.planks then
		minetest.register_node(planks, {
			description = tree.." planks",
			groups = planks_groups,
			tiles = {
				modname.."_"..tree.."_planks.png",
			},
		})
		-- Крафт из planks из log
		if tree_def.flags.log or tree_def.flags.trunk then
			minetest.register_craft({
				type = "shapeless",
				output = planks.." 4",
				recipe = {log_name},
			})
		end

		-- Крафт из planks из stick
		if tree_def.flags.stick then
			minetest.register_craft({
				output = planks,
				recipe = {
					{stick, stick},
					{stick, stick},
				}
			})
		end
	end
	-- leaf
	if tree_def.flags.leaf then
		minetest.register_node(modname..":"..tree.."_leaf", {
			drawtype = "allfaces_optional",
			description = tree.." leaf",
			groups = leaf_groups,
			tiles = {
				modname.."_"..tree.."_leaf.png",
			},
			use_texture_alfa = "clip",
			paramtype = "light",
			sunlight_propagates = true,
		})
	end
	-- flower leaf
	if tree_def.flags.flower_leaf then
		minetest.register_node(modname..":"..tree.."_flower_leaf", {
			drawtype = "allfaces_optional",
			description = tree.." flower leaf",
			groups = leaf_groups,
			tiles = {
				modname.."_"..tree.."_flower_leaf.png",
			},
			use_texture_alfa = "clip",
			paramtype = "light",
			sunlight_propagates = true,
		})
	end
	-- stick
	if tree_def.flags.stick then
		minetest.register_craftitem(stick, {
			description = tree.." stick",
			groups = stick_groups,
			inventory_image = modname.."_"..tree.."_stick.png",
		})

		-- Крафт из stick из planks
		if tree_def.flags.log or tree_def.flags.trunk then
			minetest.register_craft({
				type = "shapeless",
				output = stick.." 4",
				recipe = {planks},
			})
		end
	end
end

register_tree_blocks({
	name = "oak",

	flags = {
		trunk = true,
		log = true,
		planks = true,
		leaf = true,
		stick = true,
	},

	hardness_trunk = 2,
	hardness_planks = 2,
	oddly_breakable_by_hand = 1,
})
