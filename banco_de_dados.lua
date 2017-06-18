--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Banco de Dados
	
  ]]

-- Variavel de metodos
macromoney = {}

-- Variavel de Contas
local contas = {}

-- Diretorio do banco de dados
local pathbd = minetest.get_worldpath() .. "/macromoney"

-- Cria o diretorio caso nao exista ainda
local function mkdir(pathbd)
	if minetest.mkdir then
		minetest.mkdir(pathbd)
	else
		os.execute('mkdir "' .. pathbd .. '"')
	end
end
mkdir(pathbd)

-- Carregar uma conta na memoria
local carregar_conta = function(name)
	local input = io.open(pathbd .. "/conta_de_"..name, "r")
	if input then
		contas[name] = minetest.deserialize(input:read("*l"))
		io.close(input)
		return true
	else
		return false
	end
end

-- Remover uma conta da memoria
local descarregar_conta = function(name)
	contas[name] = nil
end

-- Salvar uma conta
local salvar_conta = function(name)
	if not contas[name] then return false end
	local output = io.open(pathbd .. "/conta_de_"..name, "w")
	output:write(minetest.serialize(contas[name]))
	io.close(output)
	return true
end

-- Forçar carregamento temporario
local carregar_temporario = function(name)
	minetest.after(TEMPO_CARREGAMENTO_TEMPORARIO, descarregar_conta, name)
	return carregar_conta(name)
end


--
-----
--------
-- Metodos globais
--
-- Definir valores na conta
function macromoney.definir(name, tipo_v, valor)
	if not contas[name] then
		if carregar_temporario(name) == false then 
			return false 
		end
	end
	if not tipo_v or not valor then return false end
	if tipo_v == "macros" then -- Macros
		if tonumber(valor) then
			contas[name].macros = tonumber(valor)
			return salvar_conta(name)
		end
	elseif tipo_v == "medalhas" then -- Medalhas
		if tonumber(valor) then
			contas[name].medalhas = tonumber(valor)
			return salvar_conta(name)
		end
	elseif tipo_v == "forum" then -- Nick no forum
		if tostring(valor) then
			contas[name].forum = tostring(valor)
			return salvar_conta(name)
		end
	else
		return false
	end
end

-- Somar valores na conta
function macromoney.somar(name, tipo_v, valor)
	if not contas[name] then
		if carregar_temporario(name) == false then 
			return false 
		end
	end
	if not tipo_v or not valor then return false end
	if tipo_v == "macros" then -- Macros
		if tonumber(valor) then
			contas[name].macros = contas[name].macros + tonumber(valor)
			return salvar_conta(name)
		end
		
	elseif tipo_v == "medalhas" then -- Medalhas
		if tonumber(valor) then
			contas[name].medalhas = contas[name].medalhas + tonumber(valor)
			return salvar_conta(name)
		end
	else
		return false
	end
end

-- Subtrair valores na conta
function macromoney.subtrair(name, tipo_v, valor, confisco)
	if not contas[name] then
		if carregar_temporario(name) == false then 
			return false 
		end
	end
	if not tipo_v or not valor then return false end
	if tipo_v == "macros" then -- Macros
		if contas[name].macros < tonumber(valor) then
			if confisco then
				contas[name].macros = 0
			else
				return false 
			end
		else
			contas[name].macros = contas[name].macros - tonumber(valor)
		end
		
		return salvar_conta(name)
	elseif tipo_v == "medalhas" then -- Medalhas
		if tonumber(valor) then
			if contas[name].macros < tonumber(valor) then
				if confisco then
					contas[name].medalhas = 0
				else
					return false 
				end
			else
				contas[name].medalhas = contas[name].medalhas - tonumber(valor)
			end
			
			return salvar_conta(name)
		end
	else
		return false
	end
end

-- Consultar valores de conta
function macromoney.consultar(name, tipo_v)
	if not contas[name] then
		if carregar_temporario(name) == false then 
			return false 
		end
	end
	if not tipo_v then return false end
	if tipo_v == "macros" then -- Macros
		return contas[name].macros
	elseif tipo_v == "medalhas" then
		return contas[name].medalhas
	elseif tipo_v == "forum" then
		return contas[name].forum
	else
		return false
	end
end

-- Verificar se uma conta existe
function macromoney.existe(name)
	local input = io.open(pathbd .. "/conta_de_"..name, "r")
	if input then
		return true
	else
		return false
	end
end

--
-- Fim dos metodos globais
--------
-----
--

-- Registrar novos jogadores
minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	contas[name] = {
		macros = 0,
		medalhas = 0,
		forum = ""
	}
	salvar_conta(name)
end)

-- Carregar dados quando o jogador conecta no servidor
minetest.register_on_joinplayer(function(player)
	if macromoney.existe(player:get_player_name()) then
		carregar_conta(player:get_player_name())
	else
		contas[player:get_player_name()] = {
			macros = 0,
			medalhas = 0,
			forum = ""
		}
		salvar_conta(player:get_player_name())
	end
end)

-- Remover dados da memoria quando o jogador desconecta do servidor
minetest.register_on_leaveplayer(function(player)
	descarregar_conta(player:get_player_name())
end)

