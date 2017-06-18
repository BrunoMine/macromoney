--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Macros
	
  ]]

-- Macro
minetest.register_craftitem("macromoney:macro", {
    description = "Macro",
    inventory_image = "macromoney_macro.png",
        stack_max = 100,
})

-- Maleta de Macros
minetest.register_craftitem("macromoney:maleta_de_macros", {
    description = "Maleta de Macros",
    inventory_image = "macromoney_maleta_de_macros.png",
        stack_max = 5,
})

-- Maleta de Macros
minetest.register_craft({
	output = "macromoney:macro 100",
	recipe = {
		{"macromoney:maleta_de_macros"},
	}
})
