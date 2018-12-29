--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Contador de Macros
	
  ]]

-- Formulario
local contador_form = "size[8,3]"..
	"label[0,0;Contador de Macros]"..
	"item_image_button[0,1;2,2;macromoney:maleta_de_macros;maleta_de_macros;]"..
	"label[2.1,1;Maleta de Macros\nPrecisa de 100 Macros]"
	--"item_image_button[0,3;2,2;macromoney:pacote_pagamento;pacote_de_pagamento;]"..
	--"label[2.1,3;Pacote de Pagamento\nPrecisa de 10 Macros]"



-- Contador de Macros
minetest.register_node("macromoney:contador_de_macros", {
	description = "Contador de Macros",
	tiles = {
		"macromoney_contador_de_macros_cima.png", -- Cima
		"macromoney_contador_de_macros.png", -- Baixo
		"macromoney_contador_de_macros.png", -- Lado Direito
		"macromoney_contador_de_macros.png", -- Lado Esquerdo
		"macromoney_contador_de_macros.png", -- Fundo
		"macromoney_contador_de_macros_frente.png" -- Frente
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {attached_node=1, oddly_breakable_by_hand=3,flammable=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.3375, 0.4375}
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.1875, 0.4375, 0.125, 0.4375}, -- Caixa
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox4
			{-0.4375, -0.5, -0.4375, 0.4375, -0.375, -0.375}, -- NodeBox5
			{0.375, -0.5, -0.4375, 0.4375, -0.375, 0.4375}, -- NodeBox6
			{-0.4375, -0.5, -0.4375, -0.375, -0.375, 0.4375}, -- NodeBox7
			{-0.3125, -0.125, -0.25, 0.3125, 0, -0.1875}, -- NodeBox8
			{-0.375, -0.375, 0.3125, 0.375, 0.3125, 0.375}, -- NodeBox9
			{-0.375, -0.375, 0.1875, 0.375, 0.1875, 0.25}, -- NodeBox10
			{-0.375, -0.5, 0.25, -0.3125, 0.1875, 0.3125}, -- NodeBox11
			{0.3125, -0.5, 0.25, 0.375, 0.1875, 0.3125}, -- NodeBox12
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", contador_form)
		meta:set_string("infotext", "Contador de Macros")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		-- Botao de Maleta de Macros
		if fields.maleta_de_macros then
			local player_inv = sender:get_inventory()
			if not player_inv:room_for_item("main", "macromoney:maleta_de_macros") then
				return minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Inventario Lotado. Tire alguns itens do seu inventario para poder pegar a Maleta de Macros")
			elseif player_inv:contains_item("main", 'macromoney:macro 100') == false then
				return minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Macros Insuficientes. Tenha ao menos 100 Macros em seu inventario")
			else
				minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Maleta de Macros montada")
				player_inv:remove_item("main", 'macromoney:macro 100')
				player_inv:add_item("main", "macromoney:maleta_de_macros")
			end
		end
		-- Botao de Pacote de Pagamento [DESCONTINUADO]
		if fields.pacote_de_pagamento then
			local player_inv = sender:get_inventory()
			if not player_inv:room_for_item("main", "macronodes:pacote_pagamento") then
				return minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Inventario Lotado. Tire alguns itens do seu inventario para poder pegar o Pacote de Pagamento")
			elseif player_inv:contains_item("main", 'macromoney:macro 25') == false then
				return minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Macros Insuficientes. Tenha ao menos 25 Macros em seu inventario")
			else
				minetest.chat_send_player(sender:get_player_name(), "[Contador de Macros] Pacote de Pagamento montado")
				player_inv:remove_item("main", 'macromoney:macro 25')
				player_inv:add_item("main", "macromoney:pacote_pagamento")
			end
		end
	end,
})

minetest.register_craft({
	output = 'macromoney:contador_de_macros',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:paper', 'default:paper', 'default:paper'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
