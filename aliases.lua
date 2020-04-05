--[[
	Mod Minemacro for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Aliases
  ]]


-- Compatibility with older mods

-- Somar
macromoney.somar = function(name, tipo_v, valor)
	if tipo_v ~= "macros" then
		minetest.log("error", "[Macromoney] Discontinued method with invalid value (tipo_v ="..dump(tipo_v)..")")
		minetest.request_shutdown("Internal error")
		return false
	end
	minetest.log("deprecated", "[Macromoney] Deprecated 'macromoney.somar' method (update code)")
	
	macromoney.add_account(name, "money", valor)
end

-- Subtrair
macromoney.subtrair = function(name, tipo_v, valor, confisco)
	if tipo_v ~= "macros" then
		minetest.log("error", "[Macromoney] Discontinued method with invalid value (tipo_v ="..dump(tipo_v)..")")
		minetest.request_shutdown("Internal error")
		return false
	end
	if confisco ~= nil then
		minetest.log("error", "[Macromoney] Discontinued method with invalid value ('confisco' param used)")
		minetest.request_shutdown("Internal error")
		return false
	end
	minetest.log("deprecated", "[Macromoney] Deprecated 'macromoney.subtrair' method (update code)")
	
	macromoney.subtract_account(name, "money", valor)
end

-- Consultar
macromoney.consultar = function(name, tipo_v)
	if tipo_v ~= "macros" then
		minetest.log("error", "[Macromoney] Discontinued method with invalid value (tipo_v ="..dump(tipo_v)..")")
		minetest.request_shutdown("Internal error")
		return false
	end
	minetest.log("deprecated", "[Macromoney] Deprecated 'macromoney.consultar' method (update code)")
	
	return macromoney.get_account(name, "money")
end

-- Existe
macromoney.existe = function(name)
	minetest.log("deprecated", "[Macromoney] Deprecated 'macromoney.existe' method (update code)")
	
	return macromoney.exist_account(name)
end


