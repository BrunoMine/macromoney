--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Itens extras
	
  ]]

minetest.register_node("macromoney:pacote_pagamento", {
	description = "Pacote de Pagamento",
	tiles = {
		"macromoney_pacote_pagamento_cima.png", -- Cima
		"macromoney_pacote_pagamento_lado.png", -- Baixo
		"macromoney_pacote_pagamento_lado.png", -- Lado direito
		"macromoney_pacote_pagamento_lado.png", -- Lado esquerda
		"macromoney_pacote_pagamento_lado.png", -- Fundo
		"macromoney_pacote_pagamento_lado.png" -- Frente
	},
	stack_max = 1,
	groups = {oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
})

-- Pacote de Pagamento
minetest.register_craft({
	output = "macromoney:macro 25",
	recipe = {
		{"macromoney:pacote_pagamento"},
	}
})
