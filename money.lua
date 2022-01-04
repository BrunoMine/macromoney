--[[
	Mod Minemacro for Minetest
	Copyright (C) 2022 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Macros
  ]]

local S = macromoney.S

-- Register macro money
macromoney.register_value("macromoney:macro", {
	description = S("Macro money"),
	specimen_prefix = "M¢",
	value_type = "number",
	initial_value = 0,
	tag = "money",
})

-- Macro
minetest.register_craftitem("macromoney:macro", {
	description = S("Macro"),
	inventory_image = "macromoney_macro.png",
	stack_max = 100,
})

-- Suitcase of Macros
--[[ Suspended
minetest.register_craftitem("macromoney:suitcase_of_macros", {
	description = S("Suitcase of Macros"),
	inventory_image = "macromoney_suitcase_of_macros.png",
	stack_max = 5,
})

minetest.register_craft({
	output = "macromoney:macro 100",
	recipe = {
		{"macromoney:suitcase_of_macros"},
	}
})
]]
