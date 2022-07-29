-- mechanics player effects

effects = {}

local CONTROL = "RMB"
local CONSUM_KEY = "consumption"
local LIMIT_TIME = 0.5
local _time = 0

-- Утоление голода
-- Следует добавить у игрока параметр голода и изменить эту ф-цию
effects.feed_hunger = function(player, feed_hunger)
	player:set_hp(player:get_hp()+feed_hunger)
end

effects.save_wield_index = function()
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local wield_index = player:get_wield_index()
		local last_wield_index = player:get_meta():get_int("last_wield_index")

		if wield_index ~= last_wield_index then
			player:get_meta():set_int("last_wield_index", wield_index)
		end
	end
end

minetest.register_globalstep(function(dtime)

	effects.save_wield_index() -- Может вызывать лаги

	_time = _time+dtime
	if not (_time >= LIMIT_TIME) then
		return
	end
	
	for _,player in ipairs(minetest.get_connected_players()) do
		if not player then _time = 0; return end
		local name = player:get_player_name() -- Это нужно?
		local stack = player:get_wielded_item()
		local meta = stack:get_meta()
		local item = stack:get_name() -- Это нужно?
		local wield_index = player:get_wield_index()
		local last_wield_index = player:get_meta():get_int("last_wield_index")
		
		if (wield_index ~= last_wield_index) then -- Если индексы не совпадают
			local inventory = player:get_inventory()
			local last_wielded_item = inventory:get_stack(player:get_wield_list(), last_wield_index)
			if last_wielded_item:get_definition().groups.food then
				local meta = last_wielded_item:get_meta()
				last_wielded_item:get_meta():set_float(CONSUM_KEY, 0)
				player:get_inventory():set_stack(player:get_wield_list(), last_wield_index, last_wielded_item)
			end
			player:get_meta():set_int("last_wield_index", wield_index) -- Возможно уже не нужно
		else
			player:get_meta():set_int("last_wield_index", wield_index) -- Возможно уже не нужно
		end

		if not item then _time = 0; return end
		if not stack:get_definition().groups.food then _time = 0; return end

		local consumption = meta:get_float(CONSUM_KEY)

		if player:get_player_control()[CONTROL] then
			meta:set_float(CONSUM_KEY, consumption+_time)
			player:set_wielded_item(stack)
		else
			stack:get_meta():set_float(CONSUM_KEY, 0)
			player:set_wielded_item(stack)
		end
		if stack:get_meta():get_float(CONSUM_KEY) >= stack:get_definition()._consumption_time then
			stack:get_meta():set_float(CONSUM_KEY, 0)
			effects.feed_hunger(player, stack:get_definition()._feed_hunger)
			stack:set_count(stack:get_count()-1)
			player:set_wielded_item(stack)
		end
	end

	_time = 0
end)
