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
		var relative_x = (camera_get_view_x(view_camera[0])-mouse_x)-inventory_start_x;
		var relative_y = (camera_get_view_y(view_camera[0])-mouse_y)-inventory_start_y;
		if((0 <= relative_x && relative_x <= inventory_width)&&((0 <= relative_y && relative_y <= inventory_height))){
			var index = relative_y/64
			index += relative_x/64
			show_debug_message(index);
		}
	}
}