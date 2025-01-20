if(!parent||parent.object_index!=PlayerObject){
	show_debug_message("Error no provided parent for Obj_Inventory");
	game_end(1)
}
inventory_start_x = (display_get_gui_width())/2-(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_end_x = (display_get_gui_width())/2-(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_start_y = (display_get_gui_height())/2-(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);
inventory_end_y = (display_get_gui_height())/2-(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);

function swap(){
	if(mouse_check_button(mb_left)){
		var relative_x = mouse_x-inventory_start_x;
		var relative_y = mouse_y-inventory_start_y;
		if((0 <= relative_x && relative_x <= inventory_end_x-inventory_start_x)&&((0 <= relative_y && relative_y <= inventory_end_y-inventory_start_y))){
			var index = relative_y/64
			index += relative_x/64
			show_debug_message(index);
		}
	}
}