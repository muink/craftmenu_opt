
local function get_data(keys)
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

local function includes(tbl, val)
	for _, item in ipairs(tbl) do
		if item == val then
			return true
		end
	end
	return false
end

local function update_entity(proto, subgroup)
	local id = proto.name

	proto.subgroup = subgroup
	if data.raw.item[id] then
		data.raw.item[id].subgroup = subgroup
	end
	if data.raw.recipe[id] then
		data.raw.recipe[id].subgroup = subgroup
	end
end

local function classify_assembling(proto)
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
	{"beacon","beacon"},
	------------------------------------------------ SCIENCE
	{"lab","lab"},
}
if mods["space-age"] then
	------------------------------------------------ PRODUCTION
	table.insert(entity_list, {{
		"fusion-reactor.fusion-reactor",
		"fusion-generator.fusion-generator",
	},"fusion-energy"})
end

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

	for _, proto in pairs(protos) do
		update_entity(proto, subgroup)
	end
end


-------------------------------------------------------------------------- LOGISTICS
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

require("stage3.module")
-------------------------------------------------------------------------- SCIENCE
-- subgroup
data.raw["item-subgroup"]["science-pack"].group = "science"

require("stage3.science-pack")
-------------------------------------------------------------------------- BARRELING
-- subgroup
data.raw["item-subgroup"]["barrel"].group = "barreling"
data.raw["item-subgroup"]["fill-barrel"].group = "barreling"
data.raw["item-subgroup"]["empty-barrel"].group = "barreling"

--require("stage3.barreling")
-------------------------------------------------------------------------- CIRCUIT
-- group
if mods["SchallCircuitGroup"] then
	data.raw["item-group"]["circuit"].order = "g[circuit]"
end
-------------------------------------------------------------------------- SIGNALS
-- group
data.raw["item-group"]["signals"].order = "g[signals]"
