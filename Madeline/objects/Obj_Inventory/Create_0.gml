selected_asset = instance_create_layer(0,0,"EntityLayer",SlotObject);

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
	
	parent.inventory[index].name = parent.inventory_swap_object.slot.name;
	parent.inventory[index].amount = parent.inventory_swap_object.slot.amount;
	parent.inventory[index].durability = parent.inventory_swap_object.slot.durability;
	with(parent.inventory_swap_object.slot){instance_reset();}
	parent.inventory_swap_object.origonal_slot = -1;
}

function swap(){
	if(mouse_check_button_pressed(mb_left)){
		var index = get_inventory_index(); 
		if (index != -1 && parent.inventory[index].name != ""){
				selected_asset.name = (parent.inventory[index].name + "Sprite");
				selected_asset.durability = (parent.inventory[index].durability);
				selected_asset.amount = (parent.inventory[index].amount);
				parent.inventory_swap_object.slot.name = parent.inventory[index].name;
				parent.inventory_swap_object.slot.amount = parent.inventory[index].amount;
				parent.inventory_swap_object.slot.durability = parent.inventory[index].durability;
				parent.inventory_swap_object.origonal_slot = index;
				with(parent.inventory[index]){instance_reset();}
		}
	}
	if(mouse_check_button_released(mb_left) && selected_asset.name != ""){
		var index = get_inventory_index();
		if(0<=index && index<slots_per_row*parent.unlocked_rows){
			if(parent.inventory[index].name == ""){
			insert_item(index);	
			}else{
				parent.inventory[parent.inventory_swap_object.origonal_slot].name = parent.inventory[index].name;
				parent.inventory[parent.inventory_swap_object.origonal_slot].amount = parent.inventory[index].amount;
				parent.inventory[parent.inventory_swap_object.origonal_slot].durability = parent.inventory[index].durability;
				insert_item(index);
			}
		}else{
			insert_item(parent.inventory_swap_object.origonal_slot);
		}
		selected_asset.name="";
		selected_asset.durability=0;
		selected_asset.amount=0;
	}
}
function grid_distance(center,goal,grid_size){
	var difference = center-goal;
	if(abs(difference)==1){
		var distance = grid_size/2;
		return((center-distance)*difference);
	}else{
		var distance = abs(difference)*grid_size-grid_size/2;
		return((center-distance)*(difference>0?1:-1));
	}
}

function drop(slot_object) {
	var temp_object = instance_create_layer(0,0,"EntityLayer",SlotObject,{name:slot_object.name,amount:slot_object.amount,durability:slot_object.durability});
	slot_object.instance_reset();
	var viewport_width = display_get_width();
	var viewport_height = display_get_height();
	var viewport_size = viewport_width<viewport_height?viewport_width:viewport_height;
	viewport_size/=3;
	var instance = asset_get_index(temp_object.name);
	var object_width = sprite_get_width(instance);
	var object_height = sprite_get_height(instance);
	var object_size = object_width>object_height?object_width:object_height;
	var grid_count = floor(viewport_size/object_size)+2;
	if(grid_count>3){
		show_debug_message("Grid Count is greater than 3");
		var grid = ds_grid_create(grid_count,grid_count);
		var center_cell_x = floor(parent.x/object_size);
		var center_cell_y = floor(parent.y/object_size);
		for(var i=0;i<grid_count;++i){
			for(var j=0; j<grid_count;++j){
				var cell_x = center_cell_x + i;
				var cell_y = center_cell_y + j;
				var world_x = cell_x*object_size + (object_size/2);
				var world_y = cell_y*object_size + (object_size/2);
				var occupied = 1;//grid value of 1 indicated that this space is occupied
					if(collision_rectangle(world_x-object_size/2,world_y-object_size/2,world_x+object_size/2,world_y+object_size/2,ColisionObjects,false,true)==noone){						
						if(collision_rectangle(world_x-object_size/2,world_y-object_size/2,world_x+object_size/2,world_y+object_size/2,ItemObject,false,true)==noone){
							if(collision_rectangle(world_x-object_size/2,world_y-object_size/2,world_x+object_size/2,world_y+object_size/2,PlayerObject,false,true)==noone){
								if(collision_rectangle(world_x-object_size/2,world_y-object_size/2,world_x+object_size/2,world_y+object_size/2,TeleportObject,false,true)==noone){
									show_debug_message($"square {i},{j} is empty");
									occupied = 0;
									mp_grid_clear_cell(grid,i,j);
								}
							}
						}

					}
					if(occupied==1){mp_grid_add_cell(grid,i,j);}
				}
		}
		var center = ((grid_count+1)/2);
		//mp_grid_path(grid,path,parent.x,parent.y,parent.x-(grid_count/2*object_size)+object_size/2,parent.y-(grid_count/2*object_size)+object_size/2,true);
		for(var i=1;i<grid_count-1;++i){
			for(var j=1; j<grid_count-1;++j){
				if(!mp_grid_get_cell(grid,i,j)){//this means this cell is empty
					//show_debug_message($"square {i},{j} is empty"
					var sprite_x = center_cell_x + i;
					var sprite_y = center_cell_y + j;
					var sprite_x = sprite_x*object_size+(object_size/2);
					var sprite_y = sprite_y*object_size+(object_size/2);
					draw_sprite_ext(EmptySprite,0,sprite_x,sprite_y,1,1,0,c_white,0.5);
					mp_grid_add_cell(grid,i,j);//mark cell as occupied
					for(var k=0;k<grid_count;++k){
						for(var l=0;l<grid_count;++l){
							if((k==0||k==grid_count-1)||(l==0||l==grid_count-1)){
								var x_distance = center_cell_x + k;
								var y_distance = center_cell_y + l;
								var x_distance = x_distance*object_size+(object_size/2);
								var y_distance = y_distance*object_size+(object_size/2);
								//show_debug_message($"checking square at {k} and {l} distance from player {x_distance}, {y_distance}");
								//return using x & y distance
								var path=path_add();
								if(mp_grid_path(grid,path,parent.x,parent.y,parent.x-x_distance,parent.y-y_distance,true)){
									show_debug_message("path_found");
									var object = string_copy(temp_object.name,1,string_length(temp_object.name)-6);
									instance_create_layer(x_distance,y_distance,"EntityLayer",asset_get_index(object+"Object"));
									return;
								}
								draw_path(path,parent.x,parent.y,1);
								
								mp_grid_clear_cell(grid,i,j)
							}
						}
					}
				}
			}
		}
	}else{
	 show_debug_message("grid_count<3")
	}
}