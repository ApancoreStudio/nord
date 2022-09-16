-- items tools

tools = {}

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/shovels.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/picks.lua")

tools.sources = {
	flint = "items_stone:flint",
	wood = "group:wood",
}

-- A special item - the hand
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

local function get_capability(itemdef, cap)
	if itemdef[cap] == nil then
		return nil
	end
	return {
		times = itemdef[cap].times,
		uses = itemdef[cap].uses,
		maxlevel = itemdef[cap].maxlevel,
		maxwear = itemdef[cap].maxwear,
	}
end

local function register_tool(tooltype, material, itemdef)
	minetest.register_tool("items_tools:"..tooltype.."_"..material, {
		description = itemdef.description,
		inventory_image = "items_tools_"..tooltype.."_"..material..".png"..
			(itemdef.image_transform or ""),
		wield_image = "items_tools_"..tooltype.."_"..material..".png"..
			(itemdef.wield_image_transform or ""),
		range = itemdef.range,
		tool_capabilities = {
			full_punch_interval = itemdef.full_punch_interval,
			max_drop_level = itemdef.max_drop_level,
			groupcaps = {
				cracky = get_capability(itemdef, "cracky"),
				choppy = get_capability(itemdef, "choppy"),
				snappy = get_capability(itemdef, "snappy"),
				crumbly = get_capability(itemdef, "crumbly")
			},
			damage_groups = itemdef.damage_groups,
		},
		groups = itemdef.groups,
		wield_scale = {x = 2, y = 2, z = 0.75},
	})
end

local function register_craft(tooltype, material, itemdef)
	if tools.sources[material] == nil then
		minetest.log("error", "Cannot find source material for the craft recipe"..
			" (output='"..material.."')")
	end
	for _, r in pairs(tools[tooltype].get_recipes(tools.sources[material])) do
		minetest.register_craft({
			output = "items_tools:"..tooltype.."_"..material,
			recipe = r
		})
	end
end

local tooltypes = {
	"shovel", "pick"
}

for _, tooltype in ipairs(tooltypes) do
	for material, _ in pairs(tools[tooltype]) do
		local itemdef = tools[tooltype][material]
		if type(itemdef) == "table" then
			register_tool(tooltype, material, itemdef)
			register_craft(tooltype, material, itemdef)
		end
	end
end

-- <<<<test>>>>

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
