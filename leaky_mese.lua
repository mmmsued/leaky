-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2024
-- Code: The LGPLv3 applies to all code in this project.
-- Media: The CC-BY-SA-3.0 license applies to textures and any other content in this project which is not source code.
-- Notice: This mode uses concepts and code from the mod »mesecons« and textures from the mod »default« (»minetest_game«)

-- to generate more blocks, see default blocks in »minetest_game\mods\default\nodes.lua«
-- Pattern: {name = " ", description = " ", tiles = {"leaky_ "}, drawtype = " "},

local definition_ghost = {    -- Beginn verschachtelte Tabelle
	{name = "acacia_bush_leaves", description = "Acacia Bush Leaves", tiles = {"leaky_acacia_leaves_simple.png"}, drawtype = "allfaces_optional"},
	{name = "aspen_leaves", description = "Aspen Leaves", tiles = {"leaky_aspen_leaves.png"}, drawtype = "allfaces_optional"},
	{name = "blueberry_bush_leaves", description = "Blueberry Bush Leaves", tiles = {"leaky_blueberry_bush_leaves.png"}, drawtype = "allfaces_optional"},
	{name = "blueberry_bush_leaves_with_berries", description = "Blueberry Bush Leaves with Berries", tiles = {"leaky_blueberry_bush_leaves.png^leaky_blueberry_overlay.png"}, drawtype = "allfaces_optional"},
	{name = "brick", description = "Brick", tiles = {"leaky_brick.png"}, drawtype = "nodebox"},
	{name = "cobble", description = "Cobblestone", tiles = {"leaky_cobble.png"}, drawtype = "nodebox"},
	{name = "desert_sandstone_brick", description = "Desert Sandstone Brick", tiles = {"leaky_desert_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "desert_stonebrick", description = "Desert Stonebrick", tiles = {"leaky_desert_stone_brick.png"}, drawtype = "nodebox"},
	{name = "diamondblock", description = "Diamond Block", tiles = {"leaky_diamond_block.png"}, drawtype = "nodebox"},
	{name = "glass", description = "Glass", tiles = {"leaky_glass.png", "leaky_glass_detail.png"}, drawtype = "glasslike_framed_optional"},
	{name = "goldblock", description = "Gold Block", tiles = {"leaky_gold_block.png"}, drawtype = "nodebox"},
	{name = "dirt_with_grass", description = "Dirt with Grass", tiles = {"leaky_grass.png", "leaky_dirt.png", {name = "leaky_dirt.png^leaky_grass_side.png",tileable_vertical = false}}, drawtype = ""},
	{name = "grass", description = "Grass", tiles = {"leaky_grass.png"}, drawtype = "nodebox"},
	{name = "gravel", description = "Gravel", tiles = {"leaky_gravel.png"}, drawtype = ""},
	{name = "bush_leaves", description = "Bush Leaves", tiles = {"leaky_leaves_simple.png"}, drawtype = "allfaces_optional"},
	{name = "mossycobble", description = "Mossy Cobble", tiles = {"leaky_mossycobble.png"}, drawtype = "nodebox"},
	{name = "obsidian_glass", description = "Obsidian Glass", tiles = {"leaky_obsidian_glass.png", "leaky_obsidian_glass_detail.png"}, drawtype = "glasslike_framed_optional"},
	{name = "sandstonebrick", description = "Sand Stonebrick", tiles = {"leaky_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "silver_sandstone_brick", description = "Silver Sandstone Brick", tiles = {"leaky_silver_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "stone", description = "Stone", tiles = {"leaky_stone.png"}, drawtype = "nodebox"},
	{name = "stone_block", description = "Stone Block", tiles = {"leaky_stone_block.png"}, drawtype = "nodebox"},
	{name = "stonebrick", description = "Stone Brick", tiles = {"leaky_stone_brick.png"}, drawtype = "nodebox"},
} -- Ende verschachtelte Tabelle

for _, row in pairs(definition_ghost) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	local name = row["name"]			
	local description = row["description"]	
	local tiles_img = row["tiles"]
	local drawtype = row["drawtype"]

	minetest.register_node("leaky:ghost_" .. name, {		-- zusammengesetzten Node-Namen generieren
		description = "Leaky Ghost " .. description,	    -- zusammengesetzte Beschreibung generieren
		tiles = tiles_img,
		drawtype = drawtype,
		is_ground_content = false,
		inventory_image = minetest.inventorycube(tiles_img[1] .. "^leaky_inv_ghost.png"), -- Inventar-Bild mit Füßen versehen
		groups = {cracky=3},
		sounds = mesecon.node_sound.stone,
		mesecons = {conductor = {
			state = mesecon.state.off,
			rules = mesecon.rules.alldirs,
			onstate = "leaky:ghost_" .. name .. "_active"
		}},
		on_blast = mesecon.on_blastnode,
	})

	minetest.register_node("leaky:ghost_" .. name .. "_active", {
		drawtype = "airlike",
		pointable = false,
		walkable = false,
		diggable = false,
		is_ground_content = false,
		sunlight_propagates = true,
		paramtype = "light",
		drop = "leaky:ghost_" .. name,
		mesecons = {conductor = {
			state = mesecon.state.on,
			rules = mesecon.rules.alldirs,
			offstate = "leaky:ghost_" .. name
		}},
		on_construct = function(pos)
			-- remove shadow
			local shadowpos = vector.add(pos, vector.new(0, 1, 0))
			if (minetest.get_node(shadowpos).name == "air") then
				minetest.dig_node(shadowpos)
			end
		end,
		on_blast = mesecon.on_blastnode,
	})
end     -- Ende for-Schleife (Start in Zeile 32)


-- Lava mit animierter Textur
minetest.register_node("leaky:ghost_lava", {
	description = "Leaky Ghost Lava",
	tiles = {
		{
			name = "leaky_lava.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "leaky_lava.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	inventory_image = minetest.inventorycube("leaky_lava.png^leaky_inv_ghost.png"),
	is_ground_content = false,
	paramtype = "light",
	light_source=minetest.LIGHT_MAX - 1,
	groups = {cracky=3},
	sounds = mesecon.node_sound.stone,
	mesecons = {conductor = {
		state = mesecon.state.off,
		rules = mesecon.rules.alldirs,
		onstate = "leaky:ghost_lava_active"
	}},
	on_blast = mesecon.on_blastnode,
})

minetest.register_node("leaky:ghost_lava_active", {
	drawtype = "airlike",
	pointable = false,
	walkable = false,
	diggable = false,
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	drop = "leaky:ghost_lava",
	mesecons = {conductor = {
		state = mesecon.state.on,
		rules = mesecon.rules.alldirs,
		offstate = "leaky:ghost_lava"
	}},
	on_construct = function(pos)
		-- remove shadow
		local shadowpos = vector.add(pos, vector.new(0, 1, 0))
		if (minetest.get_node(shadowpos).name == "air") then
			minetest.dig_node(shadowpos)
		end
	end,
	on_blast = mesecon.on_blastnode,
})


-- Wasser mit animierter Textur
minetest.register_node("leaky:ghost_water", {
	description = "Leaky Ghost Water",
	tiles = {
		{
			name = "leaky_water.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "leaky_water.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	inventory_image = minetest.inventorycube("leaky_water.png^leaky_inv_ghost.png"),
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky=3},
	sounds = mesecon.node_sound.stone,
	mesecons = {conductor = {
		state = mesecon.state.off,
		rules = mesecon.rules.alldirs,
		onstate = "leaky:ghost_water_active"
	}},
	on_blast = mesecon.on_blastnode,
})

minetest.register_node("leaky:ghost_water_active", {
	drawtype = "airlike",
	pointable = false,
	walkable = false,
	diggable = false,
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	drop = "leaky:ghost_water",
	mesecons = {conductor = {
		state = mesecon.state.on,
		rules = mesecon.rules.alldirs,
		offstate = "leaky:ghost_water"
	}},
	on_construct = function(pos)
		-- remove shadow
		local shadowpos = vector.add(pos, vector.new(0, 1, 0))
		if (minetest.get_node(shadowpos).name == "air") then
			minetest.dig_node(shadowpos)
		end
	end,
	on_blast = mesecon.on_blastnode,
})


-- keine Rezeptur für die Blöcke angelegt ... 
