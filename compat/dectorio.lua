
-- item_list
for _, tbl in pairs({
------------------------------------------------ TERRAIN
	{{"item.ice-platform"},"landscaping-earthworks","b[landfill]-f[ice-platform]"}, ---------------- space-age
	{{"item.foundation"},"landscaping-earthworks","b[landfill]-g[foundation]"}, ---------------- space-age
}) do
	table.insert(item_list, tbl)
end

-- subgroup_list
for _, tbl in pairs({
------------------------------------------------ TERRAIN
	{"waterfill","dectorio","l-b-a[waterfill]"}, ---------------- waterfill
	{"soil-improvement","dectorio","l-b-b[spaceage]"}, ---------------- space-age
	{"factorio-logo","dectorio"}, ---- factorio-logo/wubefill
}) do
	table.insert(subgroup_list, tbl)
end
