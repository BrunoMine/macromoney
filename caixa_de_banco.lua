--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Nodes
	
  ]]

-- Caixa de Banco
minetest.register_node("macromoney:caixa_de_banco", {
	description = "Caixa de Banco (Depositos e Saques)",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 3,
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	tiles = {
		"default_wood.png", -- Cima
		"default_wood.png", -- Baixo
		"default_wood.png", -- Lado direito
		"default_wood.png", -- Lado esquerda
		"default_wood.png", -- Fundo
		"macromoney_caixa_frente.png" -- Frente
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{0.3125, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox4
			{-0.5, -0.5, -0.3125, 0.5, 0.5, 0.5}, -- NodeBox5
			{-0.0625, -0.25, -0.375, 0.25, 0, 0.125}, -- NodeBox6
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	drop = "",
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		
		local formspec = "size[8,5.5;]"
			..default.gui_bg
			..default.gui_bg_img
			.."label[0.256,0;Voce pode Depositar ou Sacar 100 Macros]"
			.."button[1,0.5;2,1;sacar;Sacar]" 
			.."button[5,0.5;2,1;depositar;Depositar]"
			.."list[current_player;main;0,1.5;8,4;]"
		
		minetest.show_formspec(player:get_player_name(), "macromoney:caixa_de_banco", formspec)
	end,
 })

-- Receber campos
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "macromoney:caixa_de_banco" then
		if fields.sacar then
			local player_name = player:get_player_name()
			local player_inv = player:get_inventory()
			if not player_inv:room_for_item("main", "macromoney:macro 100") then
				minetest.chat_send_player(player_name, "Inventario Lotado")
				return true
			elseif macromoney.subtrair(player_name, "macros", 100) == false then
				minetest.chat_send_player(player_name, "Voce nao tem Macros suficientes na conta.")
				return true
			end
			player_inv:add_item("main", "macromoney:macro 100")
		elseif fields.depositar then
			local player_name = player:get_player_name()
			local player_inv = player:get_inventory()
			if not player_inv:contains_item("main", "macromoney:macro 100") then
				minetest.chat_send_player(player_name, "Macros insuficientes para Depositar (tenha ao menos 100 Macros)")
				return true
			end
			macromoney.somar(player_name, "macros", 100)
			player_inv:remove_item("main", "macromoney:macro 100")
		end
	end
end)

