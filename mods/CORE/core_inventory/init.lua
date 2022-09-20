-- core inventory

core_inventory = {}

core_inventory.tabs_button =
	"image_button[-1,0;1,2;core_inventory_craft_tab.png;tab_craft;;true;false]"..
	"image_button[-1,2;1,2;core_inventory_equip_tab.png;tab_equipment;;true;false]"

-- Вкладка крафта
core_inventory.craft_formspec =
	"list[current_player;craft;2,0.5;3,3;]"..
	"list[current_player;craftpreview;5,1.5;1,1;]"

core_inventory.storage_craft_formspec = function(player)
	local inv = player:get_inventory()
	local right_hipbag_size = inv:get_stack("equip_hipbag_right", 1):get_definition().groups.hipbag
	local left_hipbag_size = inv:get_stack("equip_hipbag_left", 1):get_definition().groups.hipbag

	local formspec = "list[current_player;main;1.5,4;4,6;]"
	if not inv:is_empty("equip_hipbag_right") then
		formspec = formspec.."list[current_player;hipbag_right;6,4;2,"..right_hipbag_size..";]"
	end

	if not inv:is_empty("equip_hipbag_left") then
		formspec = formspec.."list[current_player;hipbag_left;8,4;2,"..left_hipbag_size..";]"
	end

	return formspec
end

core_inventory.craft_tab = function(player)
	return core_inventory.craft_formspec..core_inventory.storage_craft_formspec(player)
end


-- Вкладка экпировки
core_inventory.equip_formspec =
	"image[7.5,1.5;3,6;player.png]"..
	"listcolors[#75593caa;#a3907d;#281c0f]"..
	"background[0,0;14,8;player_inventory_background.png;true]"..
	"list[current_player;equip_hipbag_right;7.1,4.5;1,1;]"..
	"list[current_player;equip_hipbag_left;9.5,4.5;1,1;]"

core_inventory.storage_equip_formspec = function(player)
	--local inv = player:get_inventory()
	--local right_hipbag_size = inv:get_stack("equip_hipbag_right", 1):get_definition().groups.hipbag
	--local left_hipbag_size = inv:get_stack("equip_hipbag_left", 1):get_definition().groups.hipbag

	local formspec = "list[current_player;main;0.5,4;4,6;]"
	--[[if not inv:is_empty("equip_hipbag_right") then
		formspec = formspec.."list[current_player;hipbag_right;7.5,5;2,"..right_hipbag_size..";]"
	end

	if not inv:is_empty("equip_hipbag_left") then
		formspec = formspec.."list[current_player;hipbag_left;9.5,5;2,"..left_hipbag_size..";]"
	end --]]

	return formspec
end

core_inventory.equip_tab = function(player)
	return core_inventory.equip_formspec..core_inventory.storage_equip_formspec(player)
end

-- Инвентарь игрока
core_inventory.player_inventory = function(player, fields)
	local formspec = "size[14,8]"

	if not fields then
		formspec = formspec..core_inventory.craft_tab(player)
	elseif fields.tab_craft then
		formspec = formspec..core_inventory.craft_tab(player)
	elseif fields.tab_equipment then
		formspec = formspec..core_inventory.equip_tab(player)
	else
		formspec = formspec..core_inventory.craft_tab(player)
	end

	formspec = formspec..core_inventory.tabs_button
	minetest.log(formspec)

	return formspec
end

minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
	local is_equip_hitpbag = inventory_info.to_list == "equip_hipbag_right" or inventory_info.to_list == "equip_hipbag_left"

	if action == "move" then
		local stack = inventory:get_stack(inventory_info.from_list, inventory_info.from_index)
		local group_hipbag = stack:get_definition().groups.hipbag ~= nil

		if is_equip_hitpbag then
			if group_hipbag then
				return 1
			else
				return 0
			end
		elseif inventory_info.from_list == "equip_hipbag_right" then
			if inventory:is_empty("hipbag_right") then
				return 1
			else
				return 0
			end
		elseif inventory_info.from_list == "equip_hipbag_left" then
			if inventory:is_empty("hipbag_left") then
				return 1
			else
				return 0
			end
		end
	end
end)

minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	local is_quip_to_hitpbag = inventory_info.to_list == "equip_hipbag_right" or inventory_info.to_list == "equip_hipbag_left"
	local is_quip_from_hitbag = inventory_info.from_list == "equip_hipbag_right" or inventory_info.from_list == "equip_hipbag_left"

	if action == "move" and (is_quip_to_hitpbag or is_quip_from_hitbag) then
		player:set_inventory_formspec(core_inventory.player_inventory(player, {tab_equipment = true}))
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	player:set_inventory_formspec(core_inventory.player_inventory(player, fields))
end)

core_inventory.set_inv_lists = function(inv)
	inv:set_size("hipbag_right", 6)
	inv:set_size("hipbag_left", 6)
	inv:set_size("main", 16)
	inv:set_size("equip_hipbag_right", 1)
	inv:set_size("equip_hipbag_left", 1)
	inv:set_size("craft", 16)
end

minetest.register_on_joinplayer(function(player)
	local inventory = player:get_inventory()
	core_inventory.set_inv_lists(inventory)
	player:hud_set_hotbar_itemcount(8)
	player:set_inventory_formspec(core_inventory.player_inventory(player))
end)
