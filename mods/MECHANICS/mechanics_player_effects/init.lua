-- mechanics player effects

effects = {}

local CONTROL_EATING = "RMB"
local CONSUM_KEY = "consumption"
local UPDATE_TIME_EATING = 0.5
-- local _time = 0 -- Неиспользуемая переменная. Удали, если не нужна (с) Доло

effects.players = {} -- Эффекты будут сохранятся при перезаходе игрока, но не будут сохранятся при выключении сервера.

effects.registered_effects = {}

-- Регистрация эффекта
effects.register_effect = function(name, def)
	effects.registered_effects[name] = {
		description = def.description or "", -- Описание эффекта
		interval = def.interval or 1, -- Интервал исполнения функции эффекта
		effect_func = def.effect_func or function() end, -- Функция эффекта
		start_effect_func = def.start_effect_func or function() end, -- Фукнция при получении эффекта
		end_effect_func = def.end_effect_func or function() end, -- Функция при окончании эффекта
	}
end

effects.register_effect("poisoning", {
	interval = 2,
	effect_func = function(player)
		local hp = player:get_hp()
		local new_hp = hp - 2
		if new_hp < 1 then new_hp = 1 end
		player:set_hp(new_hp)
	end,
})

-- Реализация эффекта
effects.realization_effect = function(player, effect, effect_def)
	local duration = effect_def.duration

	if (effect_def.last_realization - duration) >= effects.registered_effects[effect].interval then
		effects.registered_effects[effect].effect_func(player)
		effect_def.last_realization = duration
	end
end

-- Обновление эффектов и их реализация
effects.update_effects = function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local player_effects = effects.players[name]

		for effect, effect_def in pairs(player_effects) do
			effects.realization_effect(player, effect, effect_def)

			effect_def.duration = effect_def.duration - dtime

			if effect_def.duration <= 0 then
				effects.registered_effects[effect].end_effect_func(player)
				player_effects[name] = nil
			end
		end
	end
end

-- Добавить эффект
-- Возвращает false, если указанного эффекта нет
effects.add_effect = function(player, effect, duration)
	if not effects.registered_effects[effect] then return false end

	local name = player:get_player_name()
	local player_effects = effects.players[name]
	if not player_effects[effect] then
		player_effects[effect] = {
			duration = duration,
			last_realization = duration + effects.registered_effects[effect].interval
		}
		effects.registered_effects[effect].start_effect_func(player)
	else
		player_effects[effect].duration = player_effects[effect].duration + duration
		player_effects[effect].last_realization = player_effects[effect].last_realization + duration
	end
end

-- Убрать эффект (с выполнением end_effect_func)
-- Возваращет false, если указанного эффекта нет вообще или нет у игрока
effects.remove_effect = function(player, effect)
	if not effects.registered_effects[effect] then return false end

	local name = player:get_player_name()
	local player_effects = effects.players[name]
	if player_effects[effect] then
		player_effects[effect] = nil
		effects.registered_effects[effect].end_effect_func(player)
		return true
	else
		return false
	end
end

-- Команда добавить эффект
minetest.register_chatcommand("add_effect", {
    params = "<name> <effect> <duration>",

    description = "",

    func = function(name, param)
		local params = core_functions.split(param)
		local player = minetest.get_player_by_name(params[1])
		effects.add_effect(player, params[2], params[3])
    end,
})


minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not effects.players[name] then
		effects.players[name] = {}
	else
		for effect, effect_def in pairs(effects.players[name]) do
			effects.registered_effects[effect].start_effect_func(player)
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	for effect, effect_def in pairs(effects.players[name]) do
		effects.registered_effects[effect].end_effect_func(player)
	end
end)

minetest.register_globalstep(function(dtime)
	effects.update_effects(dtime)
end)

minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	effects.players[name] = {}
end)

-- Утоление голода
-- Следует добавить у игрока параметр голода и изменить эту ф-цию
effects.feed_hunger = function(player, feed_hunger)
	player:set_hp(player:get_hp()+feed_hunger)
end

effects.imitation_of_eating = function(stack)
	local name = stack
	return name -- Избавился от неиспользуемой переменной
end

core_callback.register_on_hold(function(player, control_name, hold_time)
	if control_name ~= CONTROL_EATING then return end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.food then return end

	local meta = stack:get_meta()
	local consumption = meta:get_float(CONSUM_KEY)
	local consumption_time = stack:get_definition()._consumption_time

	if hold_time >= (consumption + UPDATE_TIME_EATING) then
		meta:set_float(CONSUM_KEY, consumption + UPDATE_TIME_EATING)
		player:set_wielded_item(stack)
	end

	if hold_time >= consumption_time then
		effects.feed_hunger(player, stack:get_definition()._feed_hunger)
		meta:set_float(CONSUM_KEY, 0)
		stack:set_count(stack:get_count()-1)
		player:set_wielded_item(stack)
		core_callback.reset_hold_time(player, CONTROL_EATING)
	end
end)

core_callback.register_on_release(function(player, control_name)
	if control_name ~= CONTROL_EATING then return end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.food then return end

	local meta = stack:get_meta()
	meta:set_float(CONSUM_KEY, 0)
	player:set_wielded_item(stack)
end)

core_callback.register_on_wield_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.food then return end

	local meta = stack:get_meta()
	meta:set_float(CONSUM_KEY, 0)
	inv:set_stack("main", player_last_wield_index, stack)
end)
