if(inventory_visible){
	var x_start = 20;
	var y_start = 20;
	var current_x = x_start;
	var current_y = y_start;
	var current_row = 1;
	var item_spacing = 5;
	var item_size = 32;
//Horizontal size 32*12 + 11*5
//Vertacal size 32*rows + 5*rows-1

	for(var item_index = 0;item_index < total_inventory; ++item_index)
	{
	
		var _item = inventory[item_index];
		var item_name = _item.name;
		if(item_name == ""){break;}
		draw_sprite(asset_get_index(item_name + "Sprite"),-1,current_x,current_y);
		if(item_index + 1 >= current_row*row_length){
			current_row += 1;
			current_x = x_start;
			current_y += item_size + item_spacing;
		}else{
			current_x += item_size + item_spacing; 
		}
	}
}