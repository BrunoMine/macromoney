--[[
	Mod Minemacro for Minetest
	Copyright (C) 2022 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	API
  ]]


-- Tags
macromoney.tags = {}

-- Registered values
macromoney.registered_values = {}

-- Register value
macromoney.register_value = function(value_id, def)
	macromoney.registered_values[value_id] = def
	
	-- Tag
	if def.tag then
		macromoney.tags[def.tag] = value_id
	end
end

-- Get value ID
macromoney.get_value_id = function(tag_or_id)
	if macromoney.tags[tag_or_id] then
		return macromoney.tags[tag_or_id]
	end
	return tag_or_id
end
local get_id = macromoney.get_value_id

-- Basic methods

-- Exists account
macromoney.exist_account = function(name)
	return macromoney.db.exist(name)
end

-- Exists account value
macromoney.exist_account_value = function(name, value_id)
	local data = macromoney.db.get(name)
	if data[get_id(value_id)] ~= nil then 
		return true
	else
		return false
	end
end

-- Set
macromoney.set_account = function(name, value_id, new_value)
	local data = macromoney.db.get(name)
	data[get_id(value_id)] = new_value
	return macromoney.db.set(name, data)
end

-- Get
macromoney.get_account = function(name, value_id)
	return macromoney.db.get(name)[get_id(value_id)]
end

-- Add
macromoney.add_account = function(name, value_id, add_value)
	local data = macromoney.db.get(name)
	data[get_id(value_id)] = data[get_id(value_id)] + add_value
	macromoney.db.set(name, data)
end

-- Subtract
macromoney.subtract_account = function(name, value_id, subtract_value)
	local data = macromoney.db.get(name)
	data[get_id(value_id)] = data[get_id(value_id)] - subtract_value
	macromoney.db.set(name, data)
end

-- Check amount
macromoney.has_amount = function(name, value_id, amount)
	local data = macromoney.db.get(name)
	if data[get_id(value_id)] >= amount then
		return true
	end
	return false
end



-- Get text value
macromoney.get_value_to_text = function(value_id, value)
	local def = macromoney.registered_values[macromoney.get_value_id(value_id)]
	local prefix = def.specimen_prefix or ""
	local text
	
	-- Number type
	if def.value_type == "number" then
	
		-- Positive balance
		if value > 0 then
			text = minetest.colorize("#07ff07", prefix .. " " .. value)
			
		-- Negative balance
		elseif value < 0 then
			text = minetest.colorize("#ff0707", "-" .. prefix .. " " ..  math.abs(value)) 
		
		-- Zero
		else
			text = prefix .. " " ..  value
		end
	
	-- Text type
	else
		text = value
	end
	
	return text
end



-- Check and register player accounts
minetest.register_on_joinplayer(function(player)
	if not player then return end
	local name = player:get_player_name()
	for value_id,def in pairs(macromoney.registered_values) do
		
		-- Check if exist account
		if macromoney.exist_account(name) == false then
			-- Set all registered value
			local data = {}
			for value_id,def in pairs(macromoney.registered_values) do
				data[value_id] = def.initial_value
			end
			macromoney.db.set(name, data)
			break
		end
		
		-- Add remaning values
		if macromoney.exist_account_value(name, value_id) == false then
			macromoney.set_account(name, value_id, def.initial_value)
		end
	end
end)
