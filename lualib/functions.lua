
function get_data(keys)
    if type(keys) == "string" then
        local t = {}

        for part in string.gmatch(keys, "[^.]+") do
            table.insert(t, part)
        end
        keys = t
    end

	local current = data.raw
	for _, key in ipairs(keys) do
		if type(current) == "table" then
			current = current[key]
		else
			return nil
		end
	end
	return current
end

function includes(tbl, val)
	for _, item in ipairs(tbl) do
		if item == val then
			return true
		end
	end
	return false
end

function update_subgroup(id, group, order)
	if data.raw["item-subgroup"][id] then
		data.raw["item-subgroup"][id].group = group
		if order then
			data.raw["item-subgroup"][id].order = order
		end
	end
end

function update_item_recipe(id, subgroup, order)
	if data.raw.item[id] then
		data.raw.item[id].subgroup = subgroup
		if order then
			data.raw.item[id].order = order
		end
	end
	if data.raw.recipe[id] then
		data.raw.recipe[id].subgroup = subgroup
		if order then
			data.raw.recipe[id].order = order
		end
	end
end

function update_entity(proto, subgroup)
	local id = proto.name

	proto.subgroup = subgroup
	update_item_recipe(id, subgroup)
end

function classify_assembling(proto)
	--prototypes.categories.recipe-category

	-- vanilla
	-- basic-crafting, crafting, advanced-crafting, crafting-with-fluid ...
	if includes({"basic-crafting", "crafting", "advanced-crafting"}, proto.crafting_categories[1]) then
		update_entity(proto, "assembling-machine")
		return
	end
	if proto.crafting_categories[1] == "smelting" then
		update_entity(proto, "smelting-machine")
		return
	end
	if proto.crafting_categories[1] == "oil-processing" then
		update_entity(proto, "chemistry-machine")
		return
	end
	if proto.crafting_categories[1] == "chemistry" then
		update_entity(proto, "chemistry-machine")
		return
	end
	if proto.crafting_categories[1] == "centrifuging" then
		update_entity(proto, "assembling-machine"--[["centrifuging-machine"--]])
		return
	end

	-- space-age
	if includes({"metallurgy", "electromagnetics", "cryogenics"}, proto.crafting_categories[1]) then
		update_entity(proto, "spaceage-machine")
		return
	end
	if includes({"organic", "captive-spawner-process"}, proto.crafting_categories[1]) then
		return
	end
end
