
-- Define group icons
local icon_science = "__base__/graphics/technology/automation-science-pack.png"
if mods["space-age"] then
	icon_science = "__space-age__/graphics/technology/research-productivity.png"
end

-- Define new groups
data:extend({
-------------------------------------------------------------------------- LOGISTICS
	{
		type = "item-subgroup",
		name = "underground-belt",
		group = "logistics",
		order = "b2"
	},
	{
		type = "item-subgroup",
		name = "splitter",
		group = "logistics",
		order = "b3"
	},
	{
		type = "item-subgroup",
		name = "loader",
		group = "logistics",
		order = "b4"
	},
	{
		type = "item-subgroup",
		name = "energy-distribution",
		group = "logistics",
		order = "d1"
	},
	{
		type = "item-subgroup",
		name = "pipe-distribution",
		group = "logistics",
		order = "d2"
	},
-------------------------------------------------------------------------- PRODUCTION
	{
		type = "item-subgroup",
		name = "fossil-energy",
		group = "production",
		order = "b1"
	},
	{
		type = "item-subgroup",
		name = "renewable-energy",
		group = "production",
		order = "b2"
	},
	{
		type = "item-subgroup",
		name = "fission-energy",
		group = "production",
		order = "b3"
	},
	{
		type = "item-subgroup",
		name = "fusion-energy",
		group = "production",
		order = "b4"
	},
	{
		type = "item-subgroup",
		name = "fluid-extraction-machine",
		group = "production",
		order = "c2",
	},
	{
		type = "item-subgroup",
		name = "metallurgy-machine",
		group = "production",
		order = "d[metallurgy]",
	},
	{
		type = "item-subgroup",
		name = "assembling-machine",
		group = "production",
		order = "e1"
	},
	{
		type = "item-subgroup",
		name = "chemistry-machine",
		group = "production",
		order = "e2",
	},
	{
		type = "item-subgroup",
		name = "centrifuging-machine",
		group = "production",
		order = "e3",
	},
	{
		type = "item-subgroup",
		name = "spaceage-machine",
		group = "production",
		order = "e4",
	},
	{
		type = "item-subgroup",
		name = "beacon",
		group = "production",
		order = "f[beacon]",
	},
-------------------------------------------------------------------------- SCIENCE
	{
		type = "item-group",
		name = "science",
		order = "c-science",
		icon = icon_science,
		icon_size = 256,
	},
	{
		type = "item-subgroup",
		name = "lab",
		group = "science",
		order = "0[lab]",
	},
-------------------------------------------------------------------------- TERRAIN
	{
		type = "item-group",
		name = "terrain",
		order = "d-terrain",
		icon = "__base__/graphics/technology/concrete.png",
		icon_size = 256,
	},
	{
		type = "item-subgroup",
		name = "concrete",
		group = "terrain",
		order = "i2"
	},
	{
		type = "item-subgroup",
		name = "terrain-lifting",
		group = "terrain",
		order = "i3"
	},
	{
		type = "item-subgroup",
		name = "waterfill",
		group = "terrain",
		order = "i4"
	},
	{
		type = "item-subgroup",
		name = "soil-improvement",
		group = "terrain",
		order = "i5"
	},
	{
		type = "item-subgroup",
		name = "factorio-logo",
		group = "terrain",
		order = "w"
	},
-------------------------------------------------------------------------- COMBAT
	{
		type = "item-subgroup",
		name = "bullet-ammo",
		group = "combat",
		order = "b1"
	},
	{
		type = "item-subgroup",
		name = "shotgun-ammo",
		group = "combat",
		order = "b2"
	},
	{
		type = "item-subgroup",
		name = "cannon-ammo",
		group = "combat",
		order = "b3"
	},
	{
		type = "item-subgroup",
		name = "rocket-ammo",
		group = "combat",
		order = "b4"
	},
	{
		type = "item-subgroup",
		name = "special-ammo",
		group = "combat",
		order = "b5"
	},
	{
		type = "item-subgroup",
		name = "artillery-ammo",
		group = "combat",
		order = "b6"
	},
	{
		type = "item-subgroup",
		name = "explosive",
		group = "combat",
		order = "c1"
	},
	{
		type = "item-subgroup",
		name = "combat-robot",
		group = "combat",
		order = "c2"
	},
-------------------------------------------------------------------------- BARRELING
	{
		type = "item-group",
		name = "barreling",
		order = "f[barreling]",
		icon = "__craftmenu_opt__/graphics/item-group/barreling.png",
		icon_size = 128,
	}
})
