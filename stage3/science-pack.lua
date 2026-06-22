
local function update_science_packs(science_packs, prefix, order)
	local subgroup = prefix .. "-science-pack"

	data:extend({
		{
			type = "item-subgroup",
			name = subgroup,
			group = "science",
			order = order,
		}
	})

	for _, id in pairs(science_packs) do
		if data.raw.tool[id] then
			data.raw.tool[id].subgroup = subgroup
		end
		if data.raw.item[id] then
			data.raw.item[id].subgroup = subgroup
		end
		if data.raw.recipe[id] then
			data.raw.recipe[id].subgroup = subgroup
		end
	end
end

-------------------------------------------------------------------------- vanilla
update_science_packs({
	"automation-science-pack",
	"chemical-science-pack",
	"logistic-science-pack",
	"military-science-pack",
	"production-science-pack",
	"space-science-pack",
	"utility-science-pack",
}, "basic", "1[basic-science]")
-------------------------------------------------------------------------- space-age
if mods["space-age"] then
	update_science_packs({
		"agricultural-science-pack",
		"cryogenic-science-pack",
		"electromagnetic-science-pack",
		"metallurgic-science-pack",
		"promethium-science-pack",
	}, "space-age", "1[space-age-science]")
end
-------------------------------------------------------------------------- cerys
if mods["Cerys-Moon-of-Fulgora"] then
	update_science_packs({
		"cerysian-science-pack",
	}, "cerys", "c[cerys-science]")
end
