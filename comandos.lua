--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Comandos
	
  ]]

minetest.register_privilege("macromoney", "Manipular contas")

-- Definir o nick no forum
minetest.register_chatcommand("forum", {
	privs = {},
	params = "<nick_no_forum>",
	description = "Informa seu nickname no forum da comunidade minetest brasil",
	func = function(name, param)
		if param then
			if macromoney.definir(name, "forum", param) then
				minetest.chat_send_player(name, "Obrigado por nos informar sua conta no forum")
			else
				minetest.chat_send_player(name, "Falha ao registrar nick. (Erro interno. Avise um administrador)")
			end
		else
			minetest.chat_send_player(name, "Nenhuma conta especificada")
		end
	end
})

-- Registration "macromoney" command.
minetest.register_chatcommand("macromoney", {
	privs = {macromoney=true},
	params = "[<conta> | tirar/somar/definir <quantia> macros/medalhas <conta>]",
	description = "Operar contas",
	func = function(name,  param)

		-- Consultar propria conta
		if param == "" then --/macromoney
			if macromoney.existe(name) then
				minetest.chat_send_player(name, "Sua conta Conta")
				minetest.chat_send_player(name, "Macros: " .. macromoney.consultar(name, "macros"))
				minetest.chat_send_player(name, "Medalhas: " .. macromoney.consultar(name, "medalhas"))
				minetest.chat_send_player(name, "Registro no forum: " .. macromoney.consultar(name, "forum"))
				return true
			else
				minetest.chat_send_player(name, "Sua conta nao existe (Erro interno)")
			end
		end

		local m = string.split(param, " ")
		local param1, param2, param3, param4 = m[1], m[2], m[3], m[4]

		-- Consultar conta de outro
		if param1 and not param2 then --/macromoney <conta>
			-- Verificar se existe
			if macromoney.existe(param1) then
				minetest.chat_send_player(name, "Conta " .. param1)
				minetest.chat_send_player(name, "Macros: " .. macromoney.consultar(param1, "macros"))
				minetest.chat_send_player(name, "Medalhas: " .. macromoney.consultar(param1, "medalhas"))
				minetest.chat_send_player(name, "Registro no forum: " .. macromoney.consultar(param1, "forum"))
			else
				minetest.chat_send_player(name, "Conta inexistente")
			end
			return true
		end

		if param1 and param2 and param3 and param4 then

			-- Comando de tirar
			if param1 == "tirar" then
				if macromoney.existe(param4) then
					
					if param3 == "macros" then -- Tirar macros	
						if tonumber(param2) then
							if macromoney.subtrair(param4, param3, param2) then
								minetest.chat_send_player(name, "Macros tiradas com sucesso.")
							else
								minetest.chat_send_player(name, "O jogador nao tem macros suficientes para tirar tudo isso.")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end

					elseif param3 == "medalhas" then -- Tirar medalhas
						if tonumber(param2) then
							if macromoney.subtrair(param4, param3, param2) then
								minetest.chat_send_player(name, "Medalhas tiradas com sucesso.")
							else
								minetest.chat_send_player(name, "O jogador nao tem medalhas suficientes para tirar tudo isso.")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end
					else
						minetest.chat_send_player(name, "Pode tirar apenas macros ou medalhas")
					end
				else
					minetest.chat_send_player(name, "Jogador inexistente")
				end
				return true

			-- Comando de somar
			elseif param1 == "somar" then
				if macromoney.existe(param4) then
					
					if param3 == "macros" then -- Somar macros	
						if tonumber(param2) then
							if macromoney.somar(param4, param3, param2) then
								minetest.chat_send_player(name, "Macros somados com sucesso.")
							else
								minetest.chat_send_player(name, "Falha ao somar macros. (Erro interno)")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end

					elseif param3 == "medalhas" then -- Tirar medalhas
						if tonumber(param2) then
							if macromoney.somar(param4, param3, param2) then
								minetest.chat_send_player(name, "Medalhas somados com sucesso.")
							else
								minetest.chat_send_player(name, "Falha ao somar medalhas. (Erro interno)")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end
					else
						minetest.chat_send_player(name, "Pode tirar apenas macros ou medalhas")
					end
				else
					minetest.chat_send_player(name, "Jogador inexistente")
				end
				return true

			-- Comando de definir
			elseif param1 == "definir" then
				if macromoney.existe(param4) then
					
					if param3 == "macros" then -- Definir macros	
						if tonumber(param2) then
							if macromoney.definir(param4, param3, param2) then
								minetest.chat_send_player(name, "Macros definidos com sucesso.")
							else
								minetest.chat_send_player(name, "Falha ao definir macros. (Erro interno)")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end

					elseif param3 == "medalhas" then -- definir medalhas
						if tonumber(param2) then
							if macromoney.definir(param4, param3, param2) then
								minetest.chat_send_player(name, "Medalhas definidas com sucesso.")
							else
								minetest.chat_send_player(name, "Falha ao definir medalhas. (Erro interno)")
							end
						else
							minetest.chat_send_player(name, "Voce tem que digitar um valor numerico")
						end
					else
						minetest.chat_send_player(name, "Pode tirar apenas macros ou medalhas (veja /help macromoney)")
					end
				else
					minetest.chat_send_player(name, "Jogador inexistente")
				end
				return true
			else
				minetest.chat_send_player(name, "Pode apenas tirar, subtrar ou definir (veja /help macromoney)")
			end
		end
		minetest.chat_send_player(name, "Parametros invalidos (veja /help macromoney)")
	end,
})
