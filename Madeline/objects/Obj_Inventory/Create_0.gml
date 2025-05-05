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
    var temp_object = instance_create_layer(0, 0, "EntityLayer", SlotObject, {
        name: slot_object.name,
        amount: slot_object.amount,
        durability: slot_object.durability,
		max_durability: slot_object.max_durability,
    });
    
    slot_object.instance_reset();
    
    var instance_sprite = asset_get_index(temp_object.name);
    var object_width = sprite_get_width(instance_sprite);
    var object_height = sprite_get_height(instance_sprite);
    var object_size = max(object_width, object_height);
    
    var viewport_size = min(display_get_width(), display_get_height()) / 3;
    var grid_count = floor(viewport_size / object_size) + 2;
    
    if (grid_count <= 3) {
        show_debug_message("Grid too small to drop item safely.");
		slot_object.name = temp_object.name;
		slot_object.amount = temp_object.amount;
		slot_object.durability = temp_object.durability;
		slot_object.max_durability = temp_object.max_durability;
		instance_destroy(temp_object);
        return;
    }
    
    show_debug_message("Grid Count: " + string(grid_count));
    
    var grid = ds_grid_create(grid_count, grid_count);
    ds_grid_set_region(grid, 0, 0, grid_count - 1, grid_count - 1, 1); // all occupied initially

    var center_cell_x = floor(parent.x / object_size);
    var center_cell_y = floor(parent.y / object_size);

    // Find open cells
    for (var i = 0; i < grid_count; ++i) {
        for (var j = 0; j < grid_count; ++j) {
            var cell_x = center_cell_x + i;
            var cell_y = center_cell_y + j;
            var world_x = cell_x * object_size + (object_size / 2);
            var world_y = cell_y * object_size + (object_size / 2);
            
            if (
                collision_rectangle(world_x - object_size / 2, world_y - object_size / 2, world_x + object_size / 2, world_y + object_size / 2, ColisionObjects, false, true) == noone &&
                collision_rectangle(world_x - object_size / 2, world_y - object_size / 2, world_x + object_size / 2, world_y + object_size / 2, ItemObject, false, true) == noone &&
                collision_rectangle(world_x - object_size / 2, world_y - object_size / 2, world_x + object_size / 2, world_y + object_size / 2, PlayerObject, false, true) == noone &&
                collision_rectangle(world_x - object_size / 2, world_y - object_size / 2, world_x + object_size / 2, world_y + object_size / 2, TeleportObject, false, true) == noone
            ) {
                ds_grid_set(grid, i, j, 0); // mark cell free
            }
        }
    }

    // Spiral outward search
    for (var radius = 1; radius <= (grid_count div 2); ++radius) {
        for (var i = center_cell_x - radius; i <= center_cell_x + radius; ++i) {
            for (var j = center_cell_y - radius; j <= center_cell_y + radius; ++j) {
                var grid_x = i - center_cell_x + (grid_count div 2);
                var grid_y = j - center_cell_y + (grid_count div 2);
                
                if (grid_x >= 0 && grid_x < grid_count && grid_y >= 0 && grid_y < grid_count) {
                    if (ds_grid_get(grid, grid_x, grid_y) == 0) {
                        
                        var drop_x = i * object_size + (object_size / 2);
                        var drop_y = j * object_size + (object_size / 2);
                        
                        // FINAL collision check before creating
                        if (
                            collision_rectangle(drop_x - object_size / 2, drop_y - object_size / 2, drop_x + object_size / 2, drop_y + object_size / 2, ColisionObjects, false, true) == noone &&
                            collision_rectangle(drop_x - object_size / 2, drop_y - object_size / 2, drop_x + object_size / 2, drop_y + object_size / 2, ItemObject, false, true) == noone &&
                            collision_rectangle(drop_x - object_size / 2, drop_y - object_size / 2, drop_x + object_size / 2, drop_y + object_size / 2, PlayerObject, false, true) == noone &&
                            collision_rectangle(drop_x - object_size / 2, drop_y - object_size / 2, drop_x + object_size / 2, drop_y + object_size / 2, TeleportObject, false, true) == noone
                        ) {
                    
							if(temp_object.amount>1||(temp_object.max_durability!=-1 && temp_object.durability!=temp_object.max_durability)){
								//drop a slot object
								temp_object.x = drop_x;
								temp_object.y = drop_y;
								temp_object.set_sprite();
							}else{
								//just drop parent object
								var base_name = string_replace(temp_object.name, "Sprite", "");
	                            var object_name = base_name + "Object";
	                            var object_asset = asset_get_index(object_name);
								instance_create_layer(drop_x, drop_y, "EntityLayer", object_asset);
	                            instance_destroy(temp_object);
								
							}
                            
                            
                            ds_grid_destroy(grid);
                            return;
                        }
                    }
                }
            }
        }
    }

    // Fallback if nothing could be dropped
    show_debug_message("No safe space to drop item.");
    ds_grid_destroy(grid);
	slot_object.name = temp_object.name;
	slot_object.amount = temp_object.amount;
	slot_object.durability = temp_object.durability;
	slot_object.max_durability = temp_object.max_durability;
	instance_destroy(temp_object);
}
