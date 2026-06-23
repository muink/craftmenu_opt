
require("lualib.functions")

entity_list = {
	------------------------------------------------ LOGISTICS
	{"underground-belt","underground-belt"},
	{"splitter","splitter"},
	{"loader","loader"},
	{"electric-pole","energy-distribution"},
	{"pipe","pipe-distribution"},
	{"pipe-to-ground","pipe-distribution"},
	{"pump","pipe-distribution"},
	------------------------------------------------ PRODUCTION
	{{
		"boiler.boiler",
		"generator.steam-engine",
	},"fossil-energy"},
	{{
		"solar-panel.solar-panel",
		"accumulator.accumulator",
	},"renewable-energy"},
	{{
		"reactor.nuclear-reactor",
		"heat-pipe.heat-pipe",
		"boiler.heat-exchanger",
		"generator.steam-turbine",
	},"fission-energy"},
	{{
		"offshore-pump.offshore-pump",
		"mining-drill.pumpjack",
	},"fluid-extraction-machine"},
	{{
		"fusion-reactor.fusion-reactor",
		"fusion-generator.fusion-generator",
	},"fusion-energy"}, ---- space-age
	{"beacon","beacon"},
	------------------------------------------------ SCIENCE
	{"lab","lab"},
}

item_list = {
	------------------------------------------------ TERRAIN
	{{
		"item.wubefill",
		"item.waterfill",
		"item.deepwaterfill",
		"item.waterfill-green",
		"item.deepwaterfill-green",
		"item.shallowwaterfill",
		"item.mudwaterfill",
	},"waterfill"}, ---- waterfill
	{{
		"item.artificial-yumako-soil",
		"item.overgrowth-yumako-soil",
		"item.artificial-jellynut-soil",
		"item.overgrowth-jellynut-soil",
	},"soil-improvement"}, ---- space-age
}

subgroup_list = {
	------------------------------------------------ PRODUCTION
	{"module",nil,"f[module]"},
	{"agriculture",nil,"e5"}, ---- space-age
	{"environmental-protection",nil,"e6"}, ---- space-age
	------------------------------------------------ SCIENCE
	{"science-pack","science"},
	------------------------------------------------ BARRELING
	{{
		"barrel",
		"fill-barrel",
		"empty-barrel",
	},"barreling"},
}

group_list = {
	------------------------------------------------ CIRCUIT
	{"circuit","g[circuit]"}, ---- SchallCircuitGroup
	------------------------------------------------ SIGNALS
	{"signals","g[signals]"},
}

-------------------------------------------------------------------------- COMPAT
---- dectorio
if data.raw["item-group"]["dectorio"] then
	require("compat.dectorio")
else
	-- item_list
	for _, tbl in pairs({
	------------------------------------------------ TERRAIN
		{{
			"item.stone-brick",
			"item.concrete",
			"item.hazard-concrete",
			"item.refined-concrete",
			"item.refined-hazard-concrete",
		},"concrete"},
		{{
			"item.landfill",
			"item.ice-platform", ---- space-age
			"item.foundation", ---- space-age
			"capsule.cliff-explosives",
		},"terrain-lifting"},
	}) do
		table.insert(item_list, tbl)
	end

	-- subgroup_list
	for _, tbl in pairs({
	------------------------------------------------ TERRAIN
		{"textplates","terrain"}, ---- textplates
	}) do
		table.insert(subgroup_list, tbl)
	end
end



-- sort entities & items
for _, list in pairs({entity_list, item_list}) do
for _, args in pairs(list) do
	local protos = {}
	local subgroup = args[2]
	local order = args[3]

	if type(args[1]) == "string" then
		protos = get_data(args[1])
	elseif type(args[1]) == "table" then
		for _, key in pairs(args[1]) do
			table.insert(protos, get_data(key))
		end
	end

	if protos then
		for _, proto in pairs(protos) do
			update_proto(proto, subgroup, order)
		end
	end
end
end

-- sort subgroups
for _, args in pairs(subgroup_list) do
	local ids = args[1]
	local group = args[2]
	local order = args[3]

	if type(args[1]) == "string" then
		ids = {args[1]}
	end

	for _, id in pairs(ids) do
		update_subgroup(id, group, order)
	end
end

-- sort groups
for _, args in pairs(group_list) do
	local id = args[1]
	local order = args[2]

	update_group(id, order)
end



-------------------------------------------------------------------------- LOGISTICS
--[[
if mods["space-age"] then
	data.raw["recipe"]["casting-pipe"].hide_from_player_crafting = true
	data.raw["recipe"]["casting-pipe-to-ground"].hide_from_player_crafting = true
end
--]]
-------------------------------------------------------------------------- PRODUCTION
-- entities
for _, proto in pairs(data.raw["assembling-machine"]) do
	classify_assembling(proto)
end

-- modules
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

	proto.subgroup = subgroup
	update_item_recipe(id, subgroup)
end
-------------------------------------------------------------------------- SCIENCE
require("prototypes.item.science-pack")
