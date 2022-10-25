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

	Заметки:
		Форма имени для крафта:
		"craftitem00,craftitem01"
--]]

-- Получить координаты элемента матрицы
local function get_cord(i, w)
	local x = i%w
	if x == 0 then
		x = w
	end

	local y = math.ceil(i/w)
	minetest.log(x.." "..y)
	return x, y
end

-- Зарегистрировать в таблицу форменный крафт
local function register_shaped_craft(def)
	local recipe = ""
	for a, t in ipairs(def.recipe) do
		for b, item in ipairs(t) do
			if item ~= "" then
				recipe = recipe..item..b..a
			end
		end
	end
	core_functions.registered_crafts[recipe] = def.output
end

-- Зарегистрировать в таблицу бесформенный крафт
local function register_shapeless_craft(def)
	local recipe = table.concat(def.recipe, SEPARATOR)
	core_functions.registered_crafts[recipe] = def.output
end

-- Зарегистрировать крафт по указанному типу
-- Если тип не указать, будет shaped
core_functions.register_craft = function(def)
	local craft_type = def.type or "shaped"
	if craft_type == "shaped" or craft_type == nil then
		register_shaped_craft(def)
	elseif craft_type == "shapeless" then
		register_shapeless_craft(def)
	else
		minetest.log("error", "Неправильно указан тип крафта при регистрации. Тип "..craft_type.." не существует!")
	end
end

-- Убрать пустые элементы из строки
local function remove_empty_spaces(str)
	local new_str = str
	local k = 1
	while k ~= 0 do
		new_str, k = string.gsub(new_str, SEPARATOR..SEPARATOR, SEPARATOR)
	end
	return new_str
end

-- Отсортировать строку
local function sort_string(str)
	local tab = string.split(str, SEPARATOR)
	table.sort(tab)
	return table.concat(tab, SEPARATOR)
end

-- Получить результат форменного крафта по списку элементов и размеру
local function get_shaped_craft_result(items_name, size)
	minetest.log(table.concat(items_name, SEPARATOR)..SEPARATOR)
	local w = size.w
	local h = size.h
	local new_w = w
	local DELETE_NAME = "DELETE" -- Метка для лишних элементов
	local b = false
	-- Удалить лишние строки в начале
	for k=0, h do
		-- Если есть полностью пустая строка,
		for i=1, w, 1 do
			b = items_name[k*w+i] == "" or items_name[k*w+i] == DELETE_NAME
			if not b then break end
		end
		-- то удалить всю пустую строку
		if b then
			for i=1, w, 1 do
				items_name[k*w+i] = DELETE_NAME
			end
		else
			break
		end
	end

	-- Удалить лишние столбы слева
	for k=0, w do
		-- Если есть целый пустой столбец,
		for i=1+k, #items_name, w do
			minetest.log(i)
			b = items_name[i] == "" or items_name[i] == DELETE_NAME
			if not b then break end
		end
		-- то удалить весь пустой столбец
		if b then
			for i=1+k, #items_name, w do
				items_name[i] = DELETE_NAME
			end
			-- Уменьшить ширину из-за удаления столбца
			new_w = new_w-1
		else
			break
		end
	end

	local item_names_table = {}
	-- Удалить помеченные
	for i, name in ipairs(items_name) do
		if name ~= DELETE_NAME then
			table.insert(item_names_table,name)
		end
	end

	local item_names_string = ""
	-- Создать строку-ключ
	for i, name in ipairs(item_names_table) do
		if name ~= "" then
			local a, b = get_cord(i, new_w)
			item_names_string = item_names_string..name..a..b
		end
	end
	return core_functions.registered_crafts[item_names_string]
end

-- Получить результат бесформенного крафта по списку элементов
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
