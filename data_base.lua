--[[
	Mod Minemacro for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Data base
  ]]

-- Load memor
macromoney.memor = dofile(minetest.get_modpath("macromoney") .. "/lib/memor.lua")

-- Data base methods

macromoney.db = {}

-- Exist account
macromoney.db.exist = function(name)
	return macromoney.memor.verif("accts", name)
end

-- Set data
macromoney.db.set = function(name, data)
	macromoney.memor.salvar("accts", name, data)
end

-- Get data
macromoney.db.get = function(name)
	return macromoney.memor.pegar("accts", name)
end




