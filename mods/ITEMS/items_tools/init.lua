-- items tools

items_tools = {}

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/shovels.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/picks.lua")

items_tools.materials = {
	["flint"] = "items_stone:flint",
}

items_tools.tooltypes = {
	"shovel",
	"pick",
}

local WIELD_TOOL_SCALE = {x = 2, y = 2, z = 0.75}

-- Рука
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

local function get_capability(def, cap)
	if def[cap] == nil then
		return nil
	end
	return {
		times = def[cap].times,
		uses = def[cap].uses,
		maxlevel = def[cap].maxlevel,
		maxwear = def[cap].maxwear,
	}
end

local function register_tool(tooltype, material, def)
	minetest.register_tool("items_tools:"..tooltype.."_"..material, {
		description = def.desc,

		inventory_image = "items_tools_"..
			tooltype.."_"..
			material..".png"..
			(def.image_transform or ""),

		wield_image = "items_tools_"..
			tooltype.."_"..
			material..".png"..
			(def.wield_image_transform or ""),

		range = def.range,

		tool_capabilities = {
			full_punch_interval = def.full_punch_interval,
			max_drop_level = def.max_drop_level,
			groupcaps = {
				cracky = get_capability(def, "cracky"),
				choppy = get_capability(def, "choppy"),
				snappy = get_capability(def, "snappy"),
				crumbly = get_capability(def, "crumbly")
			},
			damage_groups = def.damage_groups,
		},

		groups = def.groups,

		wield_scale = WIELD_TOOL_SCALE,
	})
end

local function register_craft(tooltype, name_material, def)
	if items_tools.materials[name_material] == nil then
		minetest.log("error", "Cannot find source material for the craft recipe"..
			" (output='"..name_material.."')")
		return
	end

	local tools = items_tools[tooltype]
	local material = items_tools.materials[name_material]
	local craft_recipes = tools.get_craft_recipes(material)

	for _, r in pairs(craft_recipes) do
		minetest.register_craft({
			output = "items_tools:"..tooltype.."_"..name_material,
			recipe = r
		})
	end
end

for _, tooltype in ipairs(items_tools.tooltypes) do
	local tools = items_tools[tooltype]
	for material, _ in pairs(tools) do
		local def = tools[material]
		if type(def) == "table" then
			register_tool(tooltype, material, def)
			register_craft(tooltype, material, def)
		end
	end
end

-- Bows

minetest.register_tool("items_tools:bow_wooden", {
	description = "Wooden bow",
	range = 0,
	wield_scale = {x = 2, y = 2, z = 0.75},
	inventory_image = "items_tools_bow_wooden.png",
	wield_image = "items_tools_bow_wooden.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {
			times={[1]=3.00, [2]=1.60, [3]=0.60},
			uses=10,
			maxlevel=1
		},
		},
		damage_groups = {fleshy=2},
	},
	groups = {wooden = 1, bow = 1},

	_tension = 0,
})

minetest.register_tool("items_tools:bow_wooden_2", {
	description = "Wooden bow",
	range = 0,
	wield_scale = {x = 2, y = 2, z = 0.75},
	inventory_image = "items_tools_bow_wooden_2.png",
	wield_image = "items_tools_bow_wooden_2.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {
			times={[1]=3.00, [2]=1.60, [3]=0.60},
			uses=10,
			maxlevel=1
		},
		},
		damage_groups = {fleshy=2},
	},
	groups = {wooden = 1, bow = 1},

	_tension = 0,
})

minetest.register_tool("items_tools:bow_wooden_3", {
	description = "Wooden bow",
	range = 0,
	wield_scale = {x = 2, y = 2, z = 0.75},
	inventory_image = "items_tools_bow_wooden_3.png",
	wield_image = "items_tools_bow_wooden_3.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {
			times={[1]=3.00, [2]=1.60, [3]=0.60},
			uses=10,
			maxlevel=1
		},
		},
		damage_groups = {fleshy=2},
	},
	groups = {wooden = 1, bow = 1},

	_tension = 0,
})

minetest.register_tool("items_tools:bow_wooden_4", {
	description = "Wooden bow",
	range = 0,
	wield_scale = {x = 2, y = 2, z = 0.75},
	inventory_image = "items_tools_bow_wooden_4.png",
	wield_image = "items_tools_bow_wooden_4.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {
			times={[1]=3.00, [2]=1.60, [3]=0.60},
			uses=10,
			maxlevel=1
		},
		},
		damage_groups = {fleshy=2},
	},
	groups = {wooden = 1, bow = 1},

	_tension = 0,
})

minetest.register_craftitem("items_tools:arrow", {
	description = "Arrow",
	inventory_image = "items_tools_arrow.png",
	groups = {projectiles = 1, arrow = 1},
	stack_max = 99
})
