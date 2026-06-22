
for _, proto in pairs(data.raw["module"]) do
	local id = proto.name
	local subgroup = proto.category .. "-module"

	data:extend({
		{
			type = "item-subgroup",
			name = subgroup,
			group = "production",
			order = "f[" .. proto.category .."]",
		}
	})

	if data.raw.item[id] then
		data.raw.item[id].subgroup = subgroup
	end
	if data.raw.recipe[id] then
		data.raw.recipe[id].subgroup = subgroup
	end
end
