--[[
	Mod Minemacro for Minetest
	Copyright (C) 2022 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Data base
  ]]

local mod_storage = minetest.get_mod_storage()

-- Data base methods
macromoney.db = {}

--[[
	
	Data base structure
	
	<Mod storage>
	|
	|---["player:playername1"]
	|   |
	|   |---["modname:itemname1"] --> 50
	|   |---["modname:itemname2"] --> 100
	|
	|---["player:playername2"]
	    |
	    |---["modname:itemname1"] --> 30
	    |---["modname:itemname2"] --> 140

]]--

-- Exist account
macromoney.db.exist = function(name)
	return mod_storage:contains("player:"..name)
end

-- Set data
macromoney.db.set = function(name, data)
	return mod_storage:set_string("player:"..name, minetest.serialize(data))
end

-- Get data
macromoney.db.get = function(name)
	return minetest.deserialize(mod_storage:get_string("player:"..name))
end




