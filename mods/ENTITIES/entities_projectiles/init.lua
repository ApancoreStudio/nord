-- entities projectiles

-- acceleration of gravity
PROJECTILE_GRAVITY = {x = 0, y = -10, z = 0} -- Перенести константу GRAVITY куда-то в CORE или в будущее API мобов (с) Доло

projectiles = {}

projectiles.register_projectile_arrow_type = function(name, item, def)
	-- Независящие от def параметры
	minetest.register_entity(name, {
		max_hp = 1,
		physical = true,
		collide_with_objects = true,
		pointable = true, -- Потом изменить на false
		use_texture_alpha = true,
		visual_size = {x = 1.5, y = 1.5, z = 1.5},
		visual = "mesh",
		mesh = "projectile_arrow_type.obj",
		collisionbox = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},

		-- Зависящие от def параметры
		--mesh = "model.obj",
		textures = {"projectile_arrow.png"},

		-- Функции
		on_step = function(self, dtime, moveresult)
			if moveresult.collides or moveresult.standing_on_object then
				self.object:set_velocity({x = 0, y = 0, z = 0})
				self.object:set_acceleration({x = 0, y = 0, z = 0})

				if not moveresult.collisions[1] then return end
				if moveresult.collisions[1].type == "node" then return end

				local target = moveresult.collisions[1].object
				if target:get_entity_name() == name then
					self.object:set_acceleration(PROJECTILE_GRAVITY)
					target:set_acceleration(PROJECTILE_GRAVITY)
				else
					self.object:remove()
					target:set_hp(target:get_hp()-3)
				end
			else
				local vel = self.object:get_velocity()
				if vel.y ~= 0 then
					local rot = {
						x = 0,
						y = math.pi + math.atan2(vel.z, vel.x),
						z = math.atan2(vel.y, math.sqrt(vel.z*vel.z+vel.x*vel.x))}
					self.object:set_rotation(rot)
				end
			end
		end,

		on_rightclick = function(self, clicker)
			local pos = self.object:get_pos()
			self.object:remove()
			minetest.add_item(pos, item)
		end,
	})
end
