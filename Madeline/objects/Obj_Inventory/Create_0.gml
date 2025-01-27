if(!parent||parent.object_index!=PlayerObject){
	show_debug_message("Error no provided parent for Obj_Inventory");
	game_end(1)
}
inventory_start_x = (display_get_gui_width())/2-(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_end_x = (display_get_gui_width())/2-(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_start_y = (display_get_gui_height())/2-(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);
inventory_end_y = (display_get_gui_height())/2-(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);
inventory_width = inventory_end_x - inventory_start_x
inventory_height = inventory_end_y - inventory_start_y

function swap(){
	if(mouse_check_button(mb_left)){
		top_left_corner_x = parent.x - (inventory_width/2);
		top_left_corner_y = parent.y +(inventory_height/2);
		var relative_x = (view_xview[0]-mouse_x)-top_left_corner_x;
		var relative_y = (view_yview[0]-mouse_y)-top_left_corner_y;
		show_debug_message($"RelativeX: {relative_x}")
		show_debug_message($"RelativeY: {relative_y}")
		show_debug_message($"MouseX: {mouse_x}")
		show_debug_message($"MouseY: {mouse_y}")
		if((top_left_corner_x <= relative_x && relative_x <= top_left_corner_x + inventory_width)&&((top_left_corner_y <= relative_y && relative_y <= top_left_corner_y - inventory_height))){
			var index = relative_y/64
			index += relative_x/64
			show_debug_message(index);
		}
	}
}