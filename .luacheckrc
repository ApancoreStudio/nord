unused_args = false
allow_defined_top = true

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
}
