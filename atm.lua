--[[
	Mod Macromoney para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Nodes
	
  ]]

-- Money machine
minetest.register_node("macromoney:atm", {
	description = "Automatic Teller Machine",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 3,
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	tiles = {
		"default_wood.png", -- Top
		"default_wood.png", -- Bottom
		"default_wood.png", -- Right
		"default_wood.png", -- Left
		"default_wood.png", -- Back
		"macromoney_caixa_frente.png" -- Front
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{0.3125, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox4
			{-0.5, -0.5, -0.3125, 0.5, 0.5, 0.5}, -- NodeBox5
			{-0.0625, -0.25, -0.375, 0.25, 0, 0.125}, -- NodeBox6
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	drop = "",
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		
		local formspec = "size[8,5.5;]"
			..default.gui_bg
			..default.gui_bg_img
			.."label[0.256,0;You can deposit or withdraw "..macromoney.get_text_number_value("macromoney:money", 100).."]"
			.."button[1,0.5;2,1;withdraw;Withdraw]" 
			.."button[5,0.5;2,1;deposit;Deposit]"
			.."list[current_player;main;0,1.5;8,4;]"
		
		minetest.show_formspec(player:get_player_name(), "macromoney:atm", formspec)
	end,
 })

-- Receive fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "macromoney:atm" then
		
		-- Withdraw
		if fields.withdraw then
			local player_name = player:get_player_name()
			local player_inv = player:get_inventory()
			
			-- Check inventory
			if not player_inv:room_for_item("main", "macromoney:macro 100") then
				minetest.chat_send_player(player_name, "Crowded inventory")
				return true
			
			-- Check account balance
			elseif macromoney.get_account(player_name, "macromoney:money") < 100 then
				minetest.chat_send_player(player_name, "Insufficient balance for this operation.")
				return true
			end
			
			macromoney.subtract_account(player_name, "macromoney:money", 100)
			player_inv:add_item("main", "macromoney:macro 100")
			
		-- Deposit
		elseif fields.deposit then
			local player_name = player:get_player_name()
			local player_inv = player:get_inventory()
			
			-- Check inventory
			if not player_inv:contains_item("main", "macromoney:macro 100") then
				minetest.chat_send_player(player_name, "You have enough money in your inventory.")
				return true
			end
			
			macromoney.add_account(player_name, "macromoney:money", 100)
			player_inv:remove_item("main", "macromoney:macro 100")
		end
	end
end)

