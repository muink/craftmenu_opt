
for _, fluid in pairs(data.raw.fluid) do
	if data.raw.recipe["empty-" .. fluid.name .. "-barrel"] then
		data.raw.recipe["empty-" .. fluid.name .. "-barrel"]["subgroup"] = "empty-barrel"
		if data.raw.recipe[fluid.name .. "-barrel"] then
			data.raw.recipe[fluid.name .. "-barrel"]["subgroup"] = "fill-barrel"
		elseif data.raw.recipe["fill-" .. fluid.name .. "-barrel"] then
			data.raw.recipe["fill-" .. fluid.name .. "-barrel"]["subgroup"] = "fill-barrel"
		end
		if data.raw.item[fluid.name .. "-barrel"] then
			data.raw.item[fluid.name .. "-barrel"]["subgroup"] = "barrel"
		end
	end
end
