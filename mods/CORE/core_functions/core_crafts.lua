-- Core crafts
-- Создано для легкой поддержки пользовательских типов крафта

core_functions.registered_crafts = {}

local SEPARATOR = "/"

--[[
	craft_types = "shapeless" или "shaped"
	def = {
		output = "craftitem",
		recipe = {craftitem1, craftitem2 ... craftitemN}
	}

	craft_types ="shaped"
	def = {
		output = "craftitem",
		recipe =
			{{craftitem1, craftitem2},
			{craftitem3, craftitem4}}
	}

	Некоторые правила:
	- Если крафт форменный, то следует заполнять позиции "" до того момента,
		пока таблицы не образуют квадрат (прямоугольник):
		НАДО:
			{{"craftitem","",""},
			{ "craftitem","craftitem",""},
			{ "","","craftitem"},}
		НЕЛЬЗЯ:
			{{"craftitem"},
			{ "craftitem","craftitem"},
			{ "","","craftitem"},}
--]]

-- Зарегистрировать в таблицу форменный крафт
local function register_shaped_craft(def)
	local recipe = ""
	for _, t in ipairs(def.recipe) do
		recipe = recipe..table.concat(t, SEPARATOR)..SEPARATOR
	end
	minetest.log(recipe) -- потом убрать
	core_functions.registered_crafts[recipe] = def.output
end

-- Зарегистрировать в таблицу бесформенный крафт
local function register_shapeless_craft(def)
	local recipe = table.concat(def.recipe, SEPARATOR)
	minetest.log(recipe) -- потом убрать
	core_functions.registered_crafts[recipe] = def.output
end

-- Зарегистрировать крафт по указанному типу
-- Если тип не указать, будет shaped
core_functions.register_craft = function(def, craft_type)
	if craft_type == "shaped" or craft_type == nil then
		register_shaped_craft(def)
	elseif craft_type == "shapeless" then
		register_shapeless_craft(def)
	else
		minetest.log("error", "Неправильно указан тип крафта при регистрации. Тип "..craft_type.." не существует!")
	end
end

-- потом удалить
core_functions.register_craft({
	output = "craftitem",
	recipe =
		{{"one", ""},
		{"three", "four"}}
})

-- потом удалить
core_functions.register_craft({
	output = "craftitem",
	recipe = {"one", "", "three"}
},
"shapeless")

local function remove_empty_spaces(str)
	local new_str = str
	local k = 1
	while k ~= 0 do
		new_str, k = string.gsub(new_str, SEPARATOR..SEPARATOR, SEPARATOR)
	end
	return new_str
end

local function sort_string(str)
	local tab = string.split(str, SEPARATOR)
	table.sort(tab)
	return table.concat(tab, SEPARATOR)
end

local function get_shaped_craft_result(items_name, size)
	local w = size.w
	local h = size.h
	local DELETE_NAME = "DELETE" -- Метка для лишних элементов
	-- Пометить лишние окончания строк
	for k=0, w do
		for i=w-k, #items_name, w-k do
			b = items_name[i] == "" or items_name[i] == DELETE_NAME
			if not b then break end
		end
		if b then
			for i=w-k, #items_name, w-k do
				items_name[i] = DELETE_NAME
			end
		else
			break
		end
	end

	-- Пометить лишние начала строк
	for k=0, w do
		for i=k+1, #items_name, w-k do
			b = items_name[i] == "" or items_name[i] == DELETE_NAME
			if not b then break end
		end
		if b then
			for i=k+1, #items_name, w-k do
				items_name[i] = DELETE_NAME
			end
		else
			break
		end
	end

	minetest.log("GG "..table.concat(items_name, SEPARATOR)..SEPARATOR)

	-- Пометить лишние окончания столбцов
	for k=0, h do
		for i=#items_name-h*k, #items_name-h*(k+1)+1, -1 do
			b = items_name[i] == "" or items_name[i] == DELETE_NAME
			if not b then break end
		end
		if b then
			for i=#items_name-h*k, #items_name-h*(k+1)+1, -1 do
				items_name[i] = DELETE_NAME
			end
		else
			break
		end
	end

	-- Пометить лишние окончания столбцов
	for k=0, h do
		for i=k+1, h+h*k do
			b = items_name[i] == "" or items_name[i] == DELETE_NAME
			if not b then break end
		end
		if b then
			for i=k+1, h+h*k do
				items_name[i] = DELETE_NAME
			end
		else
			break
		end
	end

	minetest.log("GG "..table.concat(items_name, SEPARATOR)..SEPARATOR)
	new_items_name = {}
	-- Удалить помеченные
	for i, name in ipairs(items_name) do
		if name ~= DELETE_NAME then
			table.insert(new_items_name, name)
		end
	end

	minetest.log(table.concat(new_items_name, SEPARATOR)..SEPARATOR)
	minetest.log("---------------")
	return core_functions.registered_crafts[table.concat(new_items_name, SEPARATOR)..SEPARATOR]
end

local function get_shapeless_craft_result(items_name)
	items_name = remove_empty_spaces(items_name)
	items_name = sort_string(items_name)

	return core_functions.registered_crafts[items_name]
end

-- Получить результат форменного крафта, если такого нет, получить крафт бесформенного
local function get_craft_result(items_name, size)
	local result = get_shaped_craft_result(items_name, size)
	if result == nil then
		return get_shapeless_craft_result(items_name)
	else
		return result
	end
end

-- Size = [w = int, h = int]
core_functions.get_craft_result = function(item_list, size, craft_type)
	local items_name = {}
	-- Получаем имена всех предеметов и составляем список
	for _, itemstack in ipairs(item_list) do
		if not itemstack:is_empty() then
			table.insert(items_name, itemstack:get_name())
		else
			table.insert(items_name, "")
		end
	end

	-- Если тип не указан, выбирается по приоритету
	if craft_type == nil then
		return get_craft_result(items_name, size)
	-- Форменный тип
	elseif craft_type == "shaped" then
		return get_shaped_craft_result(items_name, size)
	-- Бесформенный тип
	elseif craft_type == "shapeless" then
		return get_shapeless_craft_result(items_name)
	else
		minetest.log("error", "Неправильно указан тип крафта при получении результата. Тип "..
		craft_type.." не существует!")
	end
end

-- Потом удалить:
minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	local inv = player:get_inventory()
	minetest.log(inventory_info.to_list)
	if action == "move" and (inventory_info.to_list == "custom_craft" or inventory_info.from_list == "custom_craft") then
		local list = inv:get_list(inventory_info.to_list)
		local result = core_functions.get_craft_result(list, {h = 3, w = 3}, "shaped")
		local result_stack = inv:get_stack("custom_craft_result", 1)
		if result then
			result_stack:set_count(1)
			result_stack:replace(result)
			inv:set_stack("custom_craft_result", 1, result_stack)
			minetest.log(result)
		else
			result_stack:set_count(0)
			inv:set_stack("custom_craft_result", 1, result_stack)
		end
	elseif action == "move" and inventory_info.from_list == "custom_craft_result" then
		inv:set_list("custom_craft", {})
	end
end)

core_functions.register_craft({
	output = "items_stone:basalt",
	recipe = {{"items_trees:oak_log"},
			{"items_trees:oak_log"},},},
	"shaped")
