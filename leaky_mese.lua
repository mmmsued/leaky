-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2024
-- Code: Except otherwise specified, all code in this project is licensed as LGPLv3.
-- Media: Except otherwise specified, all media and any other content in this project which is not source code is licensed as CC BY SA 3.0. 
-- Note: This mode uses concepts and code from the mod »mesecons« and textures from the mod »default« (»minetest_game«)

-- to generate more blocks, see default blocks in »minetest_game\mods\default\nodes.lua«
-- Pattern: {name = " ", description = " ", tiles = {" "}, drawtype = " "},

local definition_ghost = {    -- Beginn verschachtelte Tabelle
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
	{name = "dirt_with_grass", description = "Dirt with Grass", tiles = {"default_grass.png", "default_dirt.png", {name = "default_dirt.png^default_grass_side.png",tileable_vertical = false}}, drawtype = "nodebox", sounds = default.node_sound_dirt_defaults({footstep = {name = "default_grass_footstep", gain = 0.25},})},
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

for _, row in pairs(definition_ghost) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	local name = row["name"]			
	local description = row["description"]
	local tiles_img = row["tiles"]
	local drawtype = row["drawtype"] or "nodebox"
	local sounds = row["sounds"] or {}

	minetest.register_node("leaky:ghost_" .. name, {	-- zusammengesetzten Node-Namen generieren
		description = "Leaky Ghost " .. description,	-- zusammengesetzte Beschreibung generieren
		tiles = tiles_img,
		drawtype = drawtype,
		is_ground_content = false,
		inventory_image = tiles_img[1] .. "^leaky_inv_ghost.png", -- Inventar-Bild mit gelbem Punkt versehen
		-- inventory_image = minetest.inventorycube(tiles_img[1] .. "^leaky_inv_ghost.png"), -- Inventar-Bild mit gelbem Punkt versehen
		groups = {cracky=3},
		sounds = sounds,
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
end     -- Ende for-Schleife (Start in Zeile 34)


-- Lava mit animierter Textur
minetest.register_node("leaky:ghost_lava", {
	description = "Leaky Ghost Lava",
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
	inventory_image = "default_lava.png^leaky_inv_ghost.png", -- Inventar-Bild mit gelbem Punkt versehen
	-- inventory_image = minetest.inventorycube("default_lava.png^leaky_inv_ghost.png"), -- Inventar-Bild mit gelbem Punkt versehen
	is_ground_content = false,
	paramtype = "light",
	light_source=minetest.LIGHT_MAX - 1,
	groups = {cracky=3},
	-- sounds = mesecon.node_sound.stone,
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
	inventory_image = "default_water.png^leaky_inv_ghost.png", -- Inventar-Bild mit gelbem Punkt versehen
	-- inventory_image = minetest.inventorycube("default_water.png^leaky_inv_ghost.png"), -- Inventar-Bild mit gelbem Punkt versehen
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_water_defaults(),
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
