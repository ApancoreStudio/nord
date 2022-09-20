-- Entities mobs
-- Ways of thinking

-- Ищет игроков и мобов в радиусе _review
-- Возвращает таблицу ТОЛЬКО с мобами или игроками (иные сущности должны быть проигнорированы)
-- Первой сущностью скорее всего будет сам хозяин
local function find_mobs_and_players(self)
	local pos = self.object:get_pos()
	local radius = self._review
	local entities = minetest.get_objects_inside_radius(pos, radius)
	local targets = {}
	for k, entity in ipairs(entities) do
		if entity:is_player() then
			table.insert(targets, entity)
		else
			if entity:get_luaentity()._is_mob then
				table.insert(targets, entity)
			end
		end
	end
	return targets
end

local function standard_stand(self)
	minetest.log("mob is stand")
	local targets = find_mobs_and_players(self)
	if targets[2] then
		self._thinking = "aggressive"
	end
end

local function standard_aggressive(self)
	minetest.log("mob is aggressive")
	local targets = find_mobs_and_players(self)
	if not targets[2] then
		self._thinking = "stand"
	end
end

entities_mobs.register_way_of_thinking("standard", {
	["default"] = standard_stand,
	["stand"] = standard_stand,
	["aggressive"] = standard_aggressive,
})

local function set_random_target_pos(self)
	local mob_pos = self.object:get_pos()
	local mob_review = self._review

	local pos1 = {
		x = mob_pos.x+mob_review,
		y = mob_pos.y+1,
		z = mob_pos.z+mob_review,
	}
	local pos2 = {
		x = mob_pos.x-mob_review,
		y = mob_pos.y-1,
		z = mob_pos.z-mob_review,
	}

	local targets_pos = minetest.find_nodes_in_area(pos1, pos2, {"air"}, false)

	if not targets_pos then
		return false
	end

	self._target = targets_pos[math.random(#targets_pos)]
	return true
end

local function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Поведение мобов neutral
local function neutral_stand(self)
	minetest.log("stand")
	if math.random(100) > 95 then
		if set_random_target_pos(self) then
			self._thinking = "wandering"
		end
	end
end

local function neutral_wandering(self)
	minetest.log("wandering")
	local path = minetest.find_path(
		self.object:get_pos(),
		self._target,
		self._review*1.5,
		self.stepheight+2,
		2)

	if not path or #path == 0 then
		self._thinking = "stand"
		self.object:set_velocity({x = 0, y = 0, z = 0})
		return
	elseif round(self._target.x, 0) == round(self.object:get_pos().x,0) and
		round(self._target.z, 0) == round(self.object:get_pos().z,0) then
		self._thinking = "stand"
		self.object:set_velocity({x = 0, y = 0, z = 0})
		return
	end

	entities_mobs.set_target_horizontally_vel(self.object, self._target, 2)

	if self.object:get_velocity().x == 0 and self.object:get_velocity().z == 0 and self.object:get_velocity().y == 0 then
		self._thinking = "stand"
		return
	end
end

entities_mobs.register_way_of_thinking("neutral", {
	["default"] = neutral_stand,
	["stand"] = neutral_stand,
	["wandering"] = neutral_wandering,
})
