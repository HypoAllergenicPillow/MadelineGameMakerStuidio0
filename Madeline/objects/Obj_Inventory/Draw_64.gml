var current_y_position = inventory_start_y;
var current_item = 0;
for(var i=1; i<=global.max_inventory_rows;++i){
	var current_x_position = inventory_start_x;
	for(var j=1; j<=slots_per_row;++j){
		if(i<=parent.unlocked_rows){
			draw_sprite_ext(SPRInventory,0,current_x_position,current_y_position,1,1,0,c_white,1);
		}else{
			draw_sprite_ext(SPRInventory,0,current_x_position,current_y_position,1,1,0,c_grey,1);
		}
		if(current_item + 1 < array_length(parent.inventory) && parent.inventory[current_item].name!=""){
			var sprite_name = parent.inventory[current_item].name + "Sprite";
			draw_sprite_ext(asset_get_index(sprite_name),0,current_x_position+32,current_y_position+32,1,1,0,c_white,1);
			if(parent.inventory[current_item].amount>1){
				draw_text(current_x_position+32,current_y_position+32,parent.inventory[current_item].amount);
			}
		}
		current_x_position += sprite_get_width(SPRInventory);
		++current_item;
	}
	current_y_position += sprite_get_height(SPRInventory);
}
if(selected_asset != ""){
	var relative_x = -((camera_get_view_x(view_camera[0])-mouse_x));
	var relative_y = -((camera_get_view_y(view_camera[0])-mouse_y));
	draw_sprite_ext(asset_get_index(selected_asset),0,relative_x, relative_y,1,1,0,c_white,1);
}