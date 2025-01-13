var current_y_position = inventory_start_y;
for(var i=1; i<=global.max_inventory_rows;++i){
	var current_x_position = inventory_start_x;
	for(var j=1; j<=slots_per_row;++j){
		if(i<=unlocked_rows){
			draw_sprite_ext(SPRInventory,0,current_x_position,current_y_position,1,1,0,c_white,1);
		}else{
			draw_sprite_ext(SPRInventory,0,current_x_position,current_y_position,1,1,0,c_grey,1);
		}
		current_x_position += sprite_get_width(SPRInventory);
	}
	current_y_position += sprite_get_height(SPRInventory);
}