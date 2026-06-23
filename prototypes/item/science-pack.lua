
-------------------------------------------------------------------------- vanilla
local pack_list = {
	{{
		"automation-science-pack",
		"chemical-science-pack",
		"logistic-science-pack",
		"military-science-pack",
		"production-science-pack",
		"space-science-pack",
		"utility-science-pack",
	}, "basic", "1[basic-science]"},
}
-------------------------------------------------------------------------- space-age
if mods["space-age"] then
	table.insert(pack_list, {{
		"agricultural-science-pack",
		"cryogenic-science-pack",
		"electromagnetic-science-pack",
		"metallurgic-science-pack",
		"promethium-science-pack",
	}, "space-age", "1[space-age-science]"})
end
-------------------------------------------------------------------------- cerys
if mods["Cerys-Moon-of-Fulgora"] then
	table.insert(pack_list, {{
		"cerysian-science-pack",
	}, "cerys", "cerys-science"})
end

-- sort science packs
for _, args in pairs(pack_list) do
	local ids = args[1]
	local subgroup = args[2] .. "-science-pack"
	local subgrouporder = args[3]

	data:extend({
		{
			type = "item-subgroup",
			name = subgroup,
			group = "science",
			order = subgrouporder,
		}
	})

	for _, id in pairs(ids) do
		if data.raw.tool[id] then
			data.raw.tool[id].subgroup = subgroup
		end
		update_item_recipe(id, subgroup)
	end
end
