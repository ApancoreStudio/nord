-- Entities mobs
-- Mobs api

entities_mobs = {}

entities_mobs.ways_of_thinking = {}

entities_mobs.register_way_of_thinking = function(name, thinking)
	entities_mobs.ways_of_thinking[name] = thinking
end

local function mob_act(self)
	if not self then
		return
	end

	local way_of_thinking = entities_mobs.ways_of_thinking[self._way_of_thinking]

	if not way_of_thinking then
		minetest.log("Мышление "..self._way_of_thinking.." не существует!")
		return
	end

	local thinking = self._thinking

	if not thinking then
		way_of_thinking["default"](self)
	else
		way_of_thinking[thinking](self)
	end
end

entities_mobs.register_mob = function(name, def)
	minetest.register_entity(name, {
		-- Не передаются в def
		physical = true,
		collide_with_objects = true,
		visual = "mesh",
		makes_footstep_sound = true,
		damage_texture_modifier = "^[brighten",
		show_on_minimap = true,

		_thinking = DEFAULT_THINKING,
		_target = nil,
		_is_mob = true,

		-- Необязательные в def
		stepheight = def.stepheight or 1,

		-- Передаются в def
		max_hp = def.max_hp,
		mesh = def.mesh,
		textures = def.textures,
		visual_size = def.visual_size,
		collisionbox = def.collisionbox,
		selectionbox = def.collisionbox,

		_breath_max = def.breath_max,
		_armor = def.armor,
		_fraction = def.fraction,
		_friendly_fraction = def.friendly_fraction,
		_enemy_fraction = def.enemy_fraction,
		_review = def.review,
		_way_of_thinking = def.way_of_thinking,

		-- Функции
		on_step = function(self, dtime)
			mob_act(self)
		end,
	})
end
