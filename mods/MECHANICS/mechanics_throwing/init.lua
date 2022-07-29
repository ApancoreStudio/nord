-- mechanics throwing

local throwing = {}
local СONTROL_CHARGE = "RMB"
-- Время зарядки одной стадии
local TIME_CHARGE = 1

-- Стадии зарядки деревянного лука
throwing.bow_wooden_stages = {
	stages = {
			"items_tools:bow_wooden",
			"items_tools:bow_wooden_2",
			"items_tools:bow_wooden_3",
			"items_tools:bow_wooden_4",
	},
	charging_time = { 0, 1, 2, 3 },
}

-- Таблица снарядов итем = сущность, скорость
throwing.projectile_arrow = {
	["items_tools:arrow"] = {"mechanics_throwing:arrow", 30}
}

-- Зарядка лука одного вида
function bow_charge(stack, hold_time, bow_stages)
	for key, value in pairs(bow_stages.stages) do
		if stack:get_name() == value then
			if (hold_time >= bow_stages.charging_time[key]) and (#bow_stages.stages >= key+1) then
				stack:set_name(bow_stages.stages[key+1])
				return stack
			end
		end
	end
	return false
end

-- Разрядка лука одного вида
function bow_discharge(stack, bow_stages)
	stack:set_name(bow_stages.stages[1])
	return stack
end

-- Выстрел
function arrow_shot(player)
	local inv = player:get_inventory()
	local look_dir = player:get_look_dir()
	local player_pos = player:get_pos()
	local arrow_pos = {x = player_pos.x, y = player_pos.y+1.5, z = player_pos.z}
	for key, value in pairs(throwing.projectile_arrow) do
		if inv:contains_item("main", key) then
			local arrow = minetest.add_entity(arrow_pos, value[1])
			arrow:add_velocity({
				x = look_dir.x*value[2],
				y = look_dir.y*value[2],
				z = look_dir.z*value[2],
			})
			arrow:set_acceleration({x = 0, y = GRAVITY*(-1), z = 0})
			inv:remove_item("main", key)
			return
		end
	end
end

-- Есть ли в инвентаре стрелы?
function there_is_arrows(player)
	local inv = player:get_inventory()
	for key, _ in pairs(throwing.projectile_arrow) do
		if inv:contains_item("main", key) then return true end
	end
end

-- Зарядка лука по удержанию
core_callback.register_on_hold(function(player, control_name, hold_time)
	-- Зарядка на клавишу СONTROL_CHARGE
	if control_name ~= СONTROL_CHARGE then return end

	local stack = player:get_wielded_item()

	-- Если предмет не лук
	if not stack:get_definition().groups.bow then return end

	if not there_is_arrows(player) then return end

	local new_stack = bow_charge(stack, hold_time, throwing.bow_wooden_stages)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Разрядка лука при отпуске клавиши
core_callback.register_on_release(function(player, control_name)
	if control_name ~= СONTROL_CHARGE then return end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.bow then return end

	arrow_shot(player)
	
	local new_stack = bow_discharge(stack, throwing.bow_wooden_stages)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Если лук заряжался, а итем в руке сменился, то надо разрядить лук (без выстрела)
core_callback.register_on_wield_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.bow then return end

	local new_stack = bow_discharge(stack, throwing.bow_wooden_stages)
	if new_stack then
		inv:set_stack("main", player_last_wield_index, new_stack)
	end
end)

-- Регистрация снаряда-стрелы (entities_projectiles)
projectiles.register_projectile("mechanics_throwing:arrow")
