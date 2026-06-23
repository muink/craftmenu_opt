
require("lualib.functions")

local entity_list = {
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
	},"fusion-energy"}, ---------------- space-age
	{"beacon","beacon"},
	------------------------------------------------ SCIENCE
	{"lab","lab"},
}


-- sort entities
for _, args in pairs(entity_list) do
	local protos = {}
	local subgroup = args[2]

	if type(args[1]) == "string" then
		protos = get_data(args[1])
	elseif type(args[1]) == "table" then
		for _, key in pairs(args[1]) do
			table.insert(protos, get_data(key))
		end
	end

	if protos then
		for _, proto in pairs(protos) do
			update_entity(proto, subgroup)
		end
	end
end

-------------------------------------------------------------------------- PRODUCTION
-- subgroup
data.raw["item-subgroup"]["module"].order = "f[module]"
if mods["space-age"] then
	data.raw["item-subgroup"]["agriculture"].order = "e5"
	data.raw["item-subgroup"]["environmental-protection"].order = "e6"
end

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

	update_item_recipe(id, subgroup)
end
-------------------------------------------------------------------------- SCIENCE
-- subgroup
data.raw["item-subgroup"]["science-pack"].group = "science"

require("stage3.science-pack")
-------------------------------------------------------------------------- BARRELING
-- subgroup
data.raw["item-subgroup"]["barrel"].group = "barreling"
data.raw["item-subgroup"]["fill-barrel"].group = "barreling"
data.raw["item-subgroup"]["empty-barrel"].group = "barreling"

-- barreling
--[[
for _, fluid in pairs(data.raw["fluid"]) do
	local fluid_barrel = fluid.name .. "-barrel"
	if data.raw.recipe["empty-" .. fluid_barrel] then
		data.raw.recipe["empty-" .. fluid_barrel].subgroup = "empty-barrel"
		if data.raw.recipe[fluid_barrel] then
			data.raw.recipe[fluid_barrel].subgroup = "fill-barrel"
		elseif data.raw.recipe["fill-" .. fluid_barrel] then
			data.raw.recipe["fill-" .. fluid_barrel].subgroup = "fill-barrel"
		end
		if data.raw.item[fluid_barrel] then
			data.raw.item[fluid_barrel].subgroup = "barrel"
		end
	end
end
--]]
-------------------------------------------------------------------------- CIRCUIT
-- group
if data.raw["item-group"]["circuit"] then
	data.raw["item-group"]["circuit"].order = "g[circuit]"
end
-------------------------------------------------------------------------- SIGNALS
-- group
data.raw["item-group"]["signals"].order = "g[signals]"
