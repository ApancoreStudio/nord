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

local function standart_stand(self)
	minetest.log("mob is stand")
	local targets = find_mobs_and_players(self)
	if targets[2] then
		self._thinking = "aggressive"
	end
end

local function standart_aggressive(self)
	minetest.log("mob is aggressive")
	local targets = find_mobs_and_players(self)
	if not targets[2] then
		self._thinking = "stand"
	end
end

entities_mobs.register_way_of_thinking("standart", {
	["default"] = standart_stand,
	["stand"] = standart_stand,
	["aggressive"] = standart_aggressive,
})

-- Поведение мобов neutral
local function neutral_stand(self)
end

local function neutral_wandering(self)
end

entities_mobs.register_way_of_thinking("neutral", {
	["default"] = neutral_stand,
	["stand"] = neutral_stand,
	["wandering"] = neutral_wandering,
}

