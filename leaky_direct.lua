-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2024
-- Code: Except otherwise specified, all code in this project is licensed as LGPLv3.
-- Media: Except otherwise specified, all media and any other content in this project which is not source code is licensed as CC BY SA 3.0. 
-- Note: This mode uses concepts and code from the mod »mesecons« and textures from the mod »default« (»minetest_game«)

-- to generate more blocks, see default blocks in »minetest_game\mods\default\nodes.lua«
-- Pattern: {name = " ", description = " ", tiles = {" "}, drawtype = " "},

local definition_direct = {    -- Beginn verschachtelte Tabelle
	{name = "acacia_bush_leaves", description = "Acacia Bush Leaves", tiles = {"default_acacia_leaves_simple.png"}, drawtype = "allfaces_optional", sounds = default.node_sound_leaves_defaults()},
	{name = "aspen_leaves", description = "Aspen Leaves", tiles = {"default_aspen_leaves.png"}, drawtype = "allfaces_optional", sounds = default.node_sound_leaves_defaults()},
	{name = "blueberry_bush_leaves", description = "Blueberry Bush Leaves", tiles = {"default_blueberry_bush_leaves.png"}, drawtype = "allfaces_optional", sounds = default.node_sound_leaves_defaults()},
	{name = "blueberry_bush_leaves_with_berries", description = "Blueberry Bush Leaves with Berries", tiles = {"default_blueberry_bush_leaves.png^default_blueberry_overlay.png"}, drawtype = "allfaces_optional", sounds = default.node_sound_leaves_defaults()},
	{name = "bush_leaves", description = "Bush Leaves", tiles = {"default_leaves_simple.png"}, drawtype = "allfaces_optional", sounds = default.node_sound_leaves_defaults()},
	{name = "brick", description = "Brick", tiles = {"default_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "cobble", description = "Cobblestone", tiles = {"default_cobble.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "desert_sandstone_brick", description = "Desert Sandstone Brick", tiles = {"default_desert_sandstone_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "desert_stonebrick", description = "Desert Stonebrick", tiles = {"default_desert_stone_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "diamondblock", description = "Diamond Block", tiles = {"default_diamond_block.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "glass", description = "Glass", tiles = {"default_glass.png", "default_glass_detail.png"}, drawtype = "glasslike_framed_optional", sounds = default.node_sound_glass_defaults()},
	{name = "goldblock", description = "Gold Block", tiles = {"default_gold_block.png"}, drawtype = "nodebox", sounds = default.node_sound_metal_defaults()},
	{name = "dirt_with_grass", description = "Dirt with Grass", tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"}, drawtype = "nodebox", sounds = default.node_sound_dirt_defaults({footstep = {name = "default_grass_footstep", gain = 0.25},})},
	{name = "grass", description = "Grass", tiles = {"default_grass.png"}, drawtype = "nodebox", sounds = default.node_sound_dirt_defaults({footstep = {name = "default_grass_footstep", gain = 0.25},})},
	{name = "gravel", description = "Gravel", tiles = {"default_gravel.png"}, drawtype = "nodebox", sounds = default.node_sound_gravel_defaults()},
	{name = "mossycobble", description = "Mossy Cobble", tiles = {"default_mossycobble.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "obsidian_glass", description = "Obsidian Glass", tiles = {"default_obsidian_glass.png", "default_obsidian_glass_detail.png"}, drawtype = "glasslike_framed_optional", sounds = default.node_sound_glass_defaults()},
	{name = "sandstonebrick", description = "Sand Stonebrick", tiles = {"default_sandstone_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "silver_sandstone_brick", description = "Silver Sandstone Brick", tiles = {"default_silver_sandstone_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "stone", description = "Stone", tiles = {"default_stone.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "stonebrick", description = "Stone Brick", tiles = {"default_stone_brick.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()},
	{name = "stone_block", description = "Stone Block", tiles = {"default_stone_block.png"}, drawtype = "nodebox", sounds = default.node_sound_stone_defaults()}
} -- Ende verschachtelte Tabelle

for _, row in pairs(definition_direct) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	local name = row["name"]
	local description = row["description"]
	local tiles_img = row["tiles"]
	local drawtype = row["drawtype"] or "drawtype"
	local sounds = row["sounds"] or {}

	minetest.register_node("leaky:direct_" .. name, {	-- zusammengesetzten Node-Namen generieren
		description = "Leaky Direct " .. description,	-- zusammengesetzte Beschreibung generieren
		drawtype = drawtype,
		paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		tiles = tiles_img,
		inventory_image = tiles_img[1] .. "^leaky_inv_footprint.png", -- Inventar-Bild mit Fußabdruck versehen
		--inventory_image = minetest.inventorycube(tiles_img[1] .. "^leaky_inv_footprint.png"), -- Inventar-Bild mit Fußabdruck versehen
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, -0.2} -- dünne Platte von 0.2-Dicke, falls drawtype »nodebox«
			}
		},
		walkable = false,
		groups = {
			cracky = 3,
            stone = 1
		},
		sounds = sounds
	})


    -- Zugriff auf den Mod »moreblocks« (genauer auf »stairsplus« - siehe dort »API.md«) - in der »mod.conf« muss »optional_depends = moreblocks« stehen
	if minetest.get_modpath("moreblocks") then
	    stairsplus:register_all("leaky", name, "leaky:direct_" .. name, {	-- zusammengesetzte Namen generieren
            description = "Leaky Direct " .. description,					-- zusammengesetzte Beschreibung generieren
			drawtype = drawtype,
			tiles = tiles_img,
			walkable = false,
			paramtype = "light",	-- verhindert u. a. fehlerhafte Lichtberechnung bei Quadern ohne Kantenlänge 1x1x1. Nachteil: Block wird insgesamt lichtdurchlässing
			paramtype2 = "facedir",	-- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		    groups = {
			    cracky = 3,
                stone = 1,
                not_in_creative_inventory = 1   -- verhindert, dass alle Formen, die die Kreissäge produzieren kann, im Kreativ-Modus das Inventar überfluten
		    },
	    })
	end -- Ende der if-Abfrage zu minetest.get_modpath() - Start in Zeile 63

end     -- Ende for-Schleife (Start in Zeile 34)


-- Lava mit animierter Textur
minetest.register_node("leaky:direct_lava", {
	description = "Leaky Direct Lava",
	drawtype = "nodebox",
	paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
	tiles = {
		{
			name = "default_lava_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	inventory_image = "default_lava.png^leaky_inv_footprint.png", -- Inventar-Bild mit Fußabdruck versehen
	-- inventory_image = minetest.inventorycube("default_lava.png^leaky_inv_footprint.png"), -- Inventar-Bild mit Fußabdruck versehen
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.2}
		}
	},
	paramtype = "light",
	light_source=minetest.LIGHT_MAX - 1,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, -0.2},
	},
	groups = {dig_immediate=2},
})


-- Wasser mit animierter Textur
minetest.register_node("leaky:direct_water", {
	description = "Leaky Direct Water",
	drawtype = "nodebox",
	paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
	tiles = {
		{
			name = "leaky_water.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0, -- bei mir 3.0
			},
		},
		{
			name = "leaky_water.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	inventory_image = "default_water.png^leaky_inv_footprint.png", -- Inventar-Bild mit Fußabdruck versehen
	-- inventory_image = minetest.inventorycube("default_water.png^leaky_inv_footprint.png"), -- Inventar-Bild mit Fußabdruck versehen
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.2}
		}
	},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, -0.2},
	},
	groups = {dig_immediate=2},
	sounds = default.node_sound_water_defaults()
})


-- keine Rezeptur für die Blöcke angelegt ... 
