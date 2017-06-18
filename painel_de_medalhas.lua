--
-- Mod Macromoney
--
-- Painel de Medalhas

-- Painel de Medalhas
local formspec_medalhas_off = "size[8,3]"..
	"bgcolor[#080808BB;true]"..
	"background[5,5;1,1;gui_formbg.png;true]"..
	"image[0,0;3,3;macromoney_painel_medalhas.png]"..
	"label[3,0;Quadro de Medalhas\n\nTroque medalhas por algo\nna Loja de Premios.\nVeja em www.minemacro.tk\n(Apenas contas vinculadas)]"
minetest.register_node("macromoney:painel_medalhas", {
	description = "Quadro de Medalhas",
	drawtype = "nodebox",
	tiles = {"macromoney_painel_medalhas.png"},
	inventory_image = "macromoney_painel_medalhas.png",
	wield_image = "macromoney_painel_medalhas.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.45, 0.45, -0.45, 0.45, 0.55, 0.45},
		wall_bottom = {-0.45, -0.5, -0.45, 0.45, -0.45, 0.45},
		wall_side   = {-0.5, -0.45, -0.45, -0.45, 0.45, 0.45},
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", "")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	on_rightclick = function(pos, node, player)
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") == player:get_player_name() then
			local name = player:get_player_name()
			if macromoney.existe(name) == false then
				minetest.show_formspec(name, "", formspec_medalhas_off)
			else
				minetest.show_formspec(name, "", 
					"size[8,3]"..
					"bgcolor[#080808BB;true]"..
					"background[5,5;1,1;gui_formbg.png;true]"..
					"image[0,0;3,3;macromoney_painel_medalhas.png]"..
					"label[3,0;Seu Quadro de Medalhas\n\nAtualmente possui " .. macromoney.consultar(name, "medalhas") .. "\n\nTroque na Loja de Premios.\nVeja em www.minemacro.tk]"
				)
			end
		else
			minetest.chat_send_player(player:get_player_name(), "Esse Quadro de Medalhas pertence a " .. meta:get_string("owner"))
		end
	end
})

minetest.register_craft({
	output = 'macromoney:painel_medalhas',
	recipe = {
		{'macronodes:pregos', 'default:jungletree', 'macronodes:pregos'},
		{'default:gold_ingot', 'dye:dark_green', 'default:gold_ingot'},
		{'macronodes:pregos', 'default:jungletree', 'macronodes:pregos'},
	}
})

