if(!parent||parent.object_index!=PlayerObject){
	show_debug_message("Error no provided parent for Obj_Inventory");
	game_end(1)
}
inventory_start_x = (display_get_gui_width())/2-(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_end_x = (display_get_gui_width())/2+(slots_per_row*sprite_get_width(SPRInventory)/2);
inventory_start_y = (display_get_gui_height())/2-(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);
inventory_end_y = (display_get_gui_height())/2+(global.max_inventory_rows*sprite_get_height(SPRInventory)/2);
inventory_width = inventory_end_x - inventory_start_x
inventory_height = inventory_end_y - inventory_start_y
function get_inventory_index(){
	var index = -1;
	var relative_x = -((camera_get_view_x(view_camera[0])-mouse_x) + inventory_start_x);
	var relative_y = -((camera_get_view_y(view_camera[0])-mouse_y) + inventory_start_y);
	if((0 <= relative_x && relative_x <= inventory_width)&&((0 <= relative_y && relative_y <= inventory_height))){
		index = floor(relative_y/64)*slots_per_row;
		index += floor(relative_x/64);
	}
	return(index);
}
function insert_item(index){
	if(parent.inventory[index].name != ""){
		with(parent.inventory_swap_object.slot){copy(parent.inventory[index]);}
	}
	with(parent.inventory[index]){copy(inventory_swap_object.slot);}
	with(parent.inventory_swap_object.slot){instance_reset();}
	parent.inventory_swap_object.origonal_slot = -1;
}

function swap(){
	if(mouse_check_button_pressed(mb_left)){
		var index = get_inventory_index(); 
		if (index != -1 && parent.inventory[index].name != ""){
				selected_asset = (parent.inventory[index].name + "Sprite");
				with(parent.inventory_swap_object.slot){copy(parent.inventory[index]);}
				parent.inventory_swap_object.origonal_slot = index;
				with(parent.inventory[index]){instance_reset();}
		}
	}
	if(mouse_check_button_released(mb_left) && selected_asset != ""){
		var index = get_inventory_index();
		if(index != -1){
			insert_item(index);
		}
		selected_asset="";
	}
}