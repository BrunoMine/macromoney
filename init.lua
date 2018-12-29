--[[
	Mod Macromoney para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicialização de scripts
	
  ]]


dofile(minetest.get_modpath("macromoney") .. "/diretrizes.lua") -- Carregar Diretrizes.
dofile(minetest.get_modpath("macromoney") .. "/banco_de_dados.lua")
dofile(minetest.get_modpath("macromoney") .. "/macro.lua") 
--dofile(minetest.get_modpath("macromoney") .. "/pacote_pagamento.lua") [DESCONTINUADO]
dofile(minetest.get_modpath("macromoney") .. "/caixa_de_banco.lua") 
--dofile(minetest.get_modpath("macromoney") .. "/painel_de_medalhas.lua") [DESCONTINUADO]
dofile(minetest.get_modpath("macromoney") .. "/contador.lua") 
dofile(minetest.get_modpath("macromoney") .. "/comandos.lua") 


-- Tira uma medalhas quando morre [DESCONTINUADO]
--[[
minetest.register_on_dieplayer(function(player)
	if player then
		local name = player:get_player_name()
		if macromoney.subtrair(name, "medalhas", 3) then
			minetest.chat_send_player(name, "Perdeste 3 medalhas por morrer")
		end
	else
		minetest.log("error", "[macromoney] Dados inacessivel (player) (em register_on_dieplayer)")
	end
end)]]

