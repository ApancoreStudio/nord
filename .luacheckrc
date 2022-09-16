unused_args = false
allow_defined_top = true
max_line_length = false
max_cyclomatic_complexity = 10

std = "lua51"

globals = {
	"minetest", "core"
}

read_globals = {
	string = { fields = { "split" } },
	table  = { fields = { "copy", "getn" } },

	-- Silence warnings about accessing undefined fields 'sign' of global 'math'
	math = { fields = { "sign" } },

	-- Builtin
	"vector", "nodeupdate", "PseudoRandom",
	"VoxelManip", "VoxelArea",
	"ItemStack", "Settings",
	"dump", "DIR_DELIM",

	-- CORE
	"core_callback", "core_functions",

	-- ENTITIES
	"PROJECTILE_GRAVITY", "projectiles",

	-- ITEMS

	-- MECHANICS

}
