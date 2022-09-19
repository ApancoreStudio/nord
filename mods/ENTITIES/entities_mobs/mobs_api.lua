-- Entities mobs
-- Mobs api

entities_mobs = {}

entities_mobs.ways_of_thinking = {}

entities_mobs.register_way_of_thinking = function(name, thinking)
	entities_mobs.ways_of_thinking[name] = thinking
end

local function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Функция, которая определяет поведение моба,
-- согласно способу мышления и текущему мышлению.
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

		_thinking = "default",
		_target = nil,
		_is_mob = true,

		-- Необязательные в def
		stepheight = def.stepheight or 1.5,

		-- Передаются в def
		max_hp = def.max_hp,
		mesh = def.mesh,
		textures = def.textures,
		visual_size = def.visual_size,
		collisionbox = def.collisionbox,
		selectionbox = def.collisionbox,

		_breath_max = def.breath_max,
		_armor = def.armor,
		_fraction = def.fraction, -- str
		_friendly_fraction = def.friendly_fraction, -- str
		_enemy_fraction = def.enemy_fraction, -- str
		_review = def.review, -- num
		_way_of_thinking = def.way_of_thinking, -- str
		_animations = def.animations, -- table

		-- Функции
		on_step = function(self, dtime)
			mob_act(self)
		end,

		on_activate = function(self, staticdata, dtime_s)
			self.object:set_acceleration({x = 0, y = -9.81, z = 0})
		end,
	})
end

-- Определить вектор скорости для достижения координаты
-- в горизонтальной плоскости по прямой.
function entities_mobs.get_target_horizontally_vel(mob_pos, target_pos)
	local z = target_pos.z - mob_pos.z
	local x = target_pos.x - mob_pos.x
	local s = math.sqrt(x*x+z*z)
	local vel = {x = round(x/s, 3), z = round(z/s, 3), y = 0}
	return vel
end

-- Установить скорость равную speed по направлению
-- в горизонтальной плоскости к координатам.
function entities_mobs.set_target_horizontally_vel(obj_mob, target_pos, speed)
	local vector_vel = entities_mobs.get_target_horizontally_vel(obj_mob:get_pos(), target_pos)
	local vel = {x = vector_vel.x*speed, z = vector_vel.z*speed, y = 0}
	obj_mob:set_velocity(vel)
end

-- Установить анимацию anim_name.
-- Множитель скорости speed_mult необязателен (равен 1)
entities_mobs.set_animation = function(self, anim_name, speed_mult)
	local animations = self._animations
	if not animations then
		minetest.log("warning", "Попытка вызвать анимацию у "..
			self.get_entity_name()..
			". Осутствует список анимаций!")
		return false
	end

	local frame_range = animations[anim_name]
	if not frame_range then
		minetest.log("warning", "Попытка вызвать анимацию у "..
			self.get_entity_name()..
			". Осутствует анимация "..anim_name" !")
		return false
	end

	local frame_speed = (speed_mult or 1)*animations["frame_speed"]

	self.object:set_animation(frame_range, frame_speed)
	return true
end
