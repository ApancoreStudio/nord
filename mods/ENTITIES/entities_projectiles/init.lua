-- entities projectiles

-- acceleration of gravity
GRAVITY = 10

projectiles = {}

projectiles.register_projectile = function(name, def)
	-- Независящие от def параметры
	minetest.register_entity(name, {
		max_hp = 1,
		physical = true,
		collide_with_objects = true,
		pointable = true, -- Потом изменить на false
		use_texture_alpha = true,

		-- Зависящие от def параметры
		visual = "sprite",
		collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
		visual_size = {x = 1, y = 1, z = 1},
		--mesh = "model.obj",
		textures = {"items_tools_arrow.png"},
		
		-- Функции
		on_step = function(self, dtime, moveresult)
			if moveresult.collides or moveresult.standing_on_object then
				self.object:set_velocity({x = 0, y = 0, z = 0})
				self.object:set_acceleration({x = 0, y = 0, z = 0})

				if not moveresult.collisions[1] then return end
				if moveresult.collisions[1].type == "node" then return end

				local target = moveresult.collisions[1].object

				target:set_hp(target:get_hp()-3)
			end
		end,
	})
end
