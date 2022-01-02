--[[
	Mod Minemacro for Minetest
	Copyright (C) 2022 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
  ]]

local modpath = minetest.get_modpath("macromoney")

-- Global table
macromoney = {}

dofile(modpath .. "/translator.lua")
dofile(modpath .. "/data_base.lua")
dofile(modpath .. "/api.lua")

dofile(modpath .. "/commands.lua") 

dofile(modpath .. "/aliases.lua") 

-- Custom
dofile(modpath .. "/money.lua") 
dofile(modpath .. "/safe_box.lua") 
dofile(modpath .. "/atm.lua") 


