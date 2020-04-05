--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Comandos
	
  ]]

local S = macromoney.S

-- Accounts manager privilege
minetest.register_privilege("macromoney_admin", S("Accounts manager"))

-- Get text number value
local to_text = macromoney.get_value_to_text

-- Send account on chat
local send_acct_on_chat = function(name, acct_name)
	
	local acct_data = macromoney.db.get(acct_name)
	
	for value_id,def in pairs(macromoney.registered_values) do
		minetest.chat_send_player(name, def.description..": " .. to_text(value_id, acct_data[value_id]))
	end
end

-- "macromoney" command
minetest.register_chatcommand("macromoney", {
	privs = {macromoney_admin = true},
	params = S("[<account> | <add/subtract/set> <value_id>]"),
	description = S("Manage accounts"),
	func = function(name,  param)

		-- Consult self account
		if param == "" then --/macromoney
			minetest.chat_send_player(name, "***** "..S("Your account").." *****")
			send_acct_on_chat(name, name)
			return true
		end

		local m = string.split(param, " ")
		local param1, param2, param3, param4 = m[1], m[2], m[3], m[4]
		
		-- Check account
		if macromoney.exist_account(param1) == false then
			return false, S("Account not exist.")
		end
		
		-- Consultar conta de outro
		if param1 and not param2 then --/macromoney <conta>
			minetest.chat_send_player(name, "*** "..S("@1 account", param1).." ***")
			send_acct_on_chat(name, param1)
			return
		end

		if param2 and param3 and param4 then
			
			-- Check tag
			if macromoney.tags[param3] then
				param3 = macromoney.tags[param3]
			end
			
			-- Check value id
			if macromoney.registered_values[param3] == nil then
				return false, S("Ivalid value type '@1'.", param1)
			end
			
			-- Check and adjust numeric value
			if  macromoney.registered_values[param3].value_type == "number" then
				if not tonumber(param4) then
					return false, S("Invalid operation. '@1' is not numeric value.", param3)
				end
				param4 = tonumber(param4)
			end
			
			-- Substract
			if param2 == "subtract" then
				
				macromoney.subtract_account(param1, param3, param4)
				
				return true, S("Subtracted value. New balance is @1.", to_text(param3, macromoney.get_account(param1, param3)))
			end
			
			-- Add
			if param2 == "add" then
				
				macromoney.add_account(param1, param3, param4)
				
				return true, S("Added value. New balance is @1.", to_text(param3, macromoney.get_account(param1, param3)))
			end
			
			-- Set
			if param2 == "set" then
				
				macromoney.set_account(param1, param3, param4)
				
				return true, S("Setted value. New value is @1.", to_text(param3, macromoney.get_account(param1, param3)))
			end
			
		end
		return false
	end,
})
