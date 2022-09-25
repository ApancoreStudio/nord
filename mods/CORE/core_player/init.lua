-- core player

minetest.hud_replace_builtin("health", {
	hud_elem_type = "statbar",
	position  = {x = 0.5, y = 0.5},
	text = "core_player_healthbar.png",
	text2 = "core_player_healthbar_gray.png",
	number = 20,
	item = 20,
	direction = 0,
	offset = {x = -300, y = 395},
	size = {x = 37, y = 37},
})

minetest.hud_replace_builtin("breath", {
	hud_elem_type = "statbar",
	position  = {x = 0.5, y = 0.5},
	text = "core_player_breathbar.png",
	number = 20,
	item = 20,
	direction = 0,
	offset = {x = -300, y = 345},
	size = {x = 37, y = 37},
})

minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_image("core_player_hotbar.png")
	player:hud_set_hotbar_selected_image("core_player_hotbar_selected.png")
end)

