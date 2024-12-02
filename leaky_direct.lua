-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmm-sued), 2024
-- Code: The LGPLv3 applies to all code in this project.
-- Media: The CC-BY-SA-3.0 license applies to textures and any other content in this project which is not source code.
-- Notice: This mode uses code from the mod »mesecons« and textures from the mod »default« (»minetest_game«)

-- um weitere Blöcke zu generieren, Standard-Blöcke in »luanti-5.10.0-win64\games\minetest_game\mods\default\nodes.lua« ansehen
-- Muster: {name = " ", description = " ", tiles = {" "}, drawtype = " "},

local definition_direct = {    -- Beginn verschachtelte Tabelle
	{name = "acacia_bush_leaves", description = "Acacia Bush Leaves", tiles = {"leaky_acacia_leaves_simple.png"}, drawtype = "allfaces_optional"},
	{name = "aspen_leaves", description = "Aspen Leaves", tiles = {"leaky_aspen_leaves.png"}, drawtype = "allfaces_optional"},
	{name = "blueberry_bush_leaves", description = "Blueberry Bush Leaves", tiles = {"leaky_blueberry_bush_leaves.png"}, drawtype = "allfaces_optional"},
	{name = "blueberry_bush_leaves_with_berries", description = "Blueberry Bush Leaves with Berries", tiles = {"leaky_blueberry_bush_leaves.png^leaky_blueberry_overlay.png"}, drawtype = "allfaces_optional"},
	{name = "cobble", description = "Cobblestone", tiles = {"leaky_cobble.png"}, drawtype = "nodebox"},
	{name = "desert_sandstone_brick", description = "Desert Sandstone Brick", tiles = {"leaky_desert_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "desert_stonebrick", description = "Desert Stonebrick", tiles = {"leaky_desert_stone_brick.png"}, drawtype = "nodebox"},
	{name = "diamondblock", description = "Diamond Block", tiles = {"leaky_diamond_block.png"}, drawtype = "nodebox"},
	{name = "glass", description = "Glass", tiles = {"leaky_glass.png", "leaky_glass_detail.png"}, drawtype = "glasslike_framed_optional"},
	{name = "goldblock", description = "Gold Block", tiles = {"leaky_gold_block.png"}, drawtype = "nodebox"},
	{name = "dirt_with_grass", description = "Dirt with Grass", tiles = {"leaky_grass.png", "leaky_dirt.png", {name = "leaky_dirt.png^leaky_grass_side.png",tileable_vertical = false}}, drawtype = "nodebox"},
	{name = "grass", description = "Grass", tiles = {"leaky_grass.png"}, drawtype = "nodebox"},
	{name = "gravel", description = "Gravel", tiles = {"leaky_gravel.png"}, drawtype = "nodebox"},
	{name = "bush_leaves", description = "Bush Leaves", tiles = {"leaky_leaves_simple.png"}, drawtype = "allfaces_optional"},
	{name = "mossycobble", description = "Mossy Cobble", tiles = {"leaky_mossycobble.png"}, drawtype = "nodebox"},
	{name = "obsidian_glass", description = "Obsidian Glass", tiles = {"leaky_obsidian_glass.png", "leaky_obsidian_glass_detail.png"}, drawtype = "glasslike_framed_optional"},
	{name = "sandstonebrick", description = "Sand Stonebrick", tiles = {"leaky_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "silver_sandstone_brick", description = "Silver Sandstone Brick", tiles = {"leaky_silver_sandstone_brick.png"}, drawtype = "nodebox"},
	{name = "stone", description = "Stone", tiles = {"leaky_stone.png"}, drawtype = "nodebox"},
	{name = "stone_block", description = "Stone Block", tiles = {"leaky_stone_block.png"}, drawtype = "nodebox"},
	{name = "stonebrick", description = "Stone Brick", tiles = {"leaky_stone_brick.png"}, drawtype = "nodebox"},
} -- Ende verschachtelte Tabelle

for _, row in pairs(definition_direct) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	local name = row["name"]			
	local description = row["description"]	
	local tiles_img = row["tiles"]
	local drawtype = row["drawtype"]

	minetest.register_node("leaky:" .. name, {			-- zusammengesetzten Node-Namen generieren
		description = "Leaky Nodes " .. description,	-- zusammengesetzte Beschreibung generieren
		drawtype = drawtype,
		paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		tiles = tiles_img,
		inventory_image = minetest.inventorycube(tiles_img[1] .. "^leaky_inv_footprint.png"), -- Inventar-Bild mit Füßen versehen
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
		}
	})


    -- Zugriff auf den Mod »moreblocks« (genauer auf »stairsplus« - siehe dort »API.md«) - in der »mod.conf« muss »optional_depends = moreblocks« stehen
	if minetest.get_modpath("moreblocks") then
	    stairsplus:register_all("leaky", name, "leaky:" .. name, {	-- zusammengesetzte Namen generieren
            description = "Leaky Nodes " .. description,				-- zusammengesetzte Beschreibung generieren
			drawtype = drawtype,
			tiles = tiles,
			walkable = false,
			paramtype = "light",	-- verhindert u. a. fehlerhafte Lichtberechnung bei Quadern ohne Kantenlänge 1x1x1. Nachteil: Block wird insgesamt lichtdurchlässing
			paramtype2 = "facedir",	-- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		    groups = {
			    cracky = 3,
                stone = 1,
                not_in_creative_inventory = 1   -- verhindert, dass alle Formen, die die Kreissäge produzieren kann, im Kreativ-Modus das Inventar überfluten
		    },
	    })
	end -- Ende der if-Abfrage zu minetest.get_modpath() - Start in Zeile 60

end     -- Ende for-Schleife (Start in Zeile 32)


-- Lava mit animierter Textur
minetest.register_node("leaky:lava", {
	description = "Leaky Node Lava",
	drawtype = "nodebox",
	paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
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
	inventory_image = minetest.inventorycube("leaky_lava.png^leaky_inv_footprint.png"), -- Inventar-Bild mit Füßen versehen
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
minetest.register_node("leaky:water", {
	description = "Leaky Node Water",
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
	inventory_image = minetest.inventorycube("leaky_water.png^leaky_inv_footprint.png"), -- Inventar-Bild mit Füßen versehen
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
})


-- keine Rezeptur für die Blöcke angelegt ... 
