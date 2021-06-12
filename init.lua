local function register_wood(name, desc)

  stickName = "core:"..name.."Stick"
  logName = "core:"..name.."Log"
  logStrippedName = "core:"..name.."LogStripped"
  plankName = "core:"..name.."Plank"
  planksBlockName = "core:"..name.."PlanksBlock"
  leafName = "core:"..name.."Leaf"
  saplingName = "core:"..name.."Sapling"
  barkName = "core:"..name.."Bark"
  
  minetest.register_craftitem(stickName,
    {
    description = desc.." stick",
    inventory_image = name.."_stick.png"
  })
  
  minetest.register_craftitem(barkName,
    {
    description = desc.." bark",
    inventory_image = name.."_bark.png"
  })
  
  minetest.register_craftitem(plankName,
    {
    description = desc.." plank",
    inventory_image = name.."_plank.png"
  })
  
  minetest.register_node(logName,
    {
    description = desc.." log",
    tiles = {name.."_log_top.png", name.."_log_top.png", name.."_log_side.png"},
    groups = {choppy = 2},
    on_rightclick = logStrippedName
  })
  
  minetest.register_node(logStrippedName,
    {
    description = desc.." stipped log",
    tiles = {name.."_log_stripped_top.png", name.."_log_stripped_top.png", name.."_log_stripped_side.png"},
    groups = {choppy = 2}
  })
  
  minetest.register_node(planksBlockName,
    {
    description = desc.." planks block",
    tiles = {name.."_planks_block.png"},
    groups = {choppy = 2}
  })
  
  minetest.register_node(barkBlockName,
    {
    description = desc.." bark block",
    tiles = {name.."_bark_block.png"},
    groups = {choppy = 2}
  })
  
  minetest.register_node(leafName,
    {
    description = desc.." leaf",
    tiles = {name.."_leaf.png"},
    drawtype = allfaces_optional,
    groups = {snappy = 2}
    drop = {
      max_items = 2,
      items = {
              {items = {stickName}, rarity = 7}, 
              {items = {saplingName}, rarity = 5}
      }}
  })
  
  minetest.register_node(saplingName,
    {
    description = desc.." sapling",
    tiles = {name.."_saplig"},
    inventory_image = name.."_sapling.png",
    drawtype = plantlike,
    groups = {snappy = 2}
  })
  
  minetest.register_craft({
    output = planks.." 16",
    recipe = {logStrippedName}
  })
  
  minetest.register_craft({
    output = planksBlockName,
    recipe = {
        {plankName, plankName},
        {plankName, plankName}
    }
  })
  
  minetest.register_craft({
    output = barkBlockName,
    recipe = {
        {barkName, barkName},
        {barkName, barkName}
    }
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = logName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = logStrippedName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = plankName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = planksBlockName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = barkName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = barkBlockName,
    burntime = 300,
  })
  
  minetest.register_craft({
    type = "fuel",
    recipe = stickName,
    burntime = 300,
  })
  
  return true
end
