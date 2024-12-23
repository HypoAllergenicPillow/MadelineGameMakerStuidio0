horizontal_speed = 0;
vertical_speed = 0;
walk_speed = 4;
sprint_speed = 8;

//view_camera[0] = camera_create_view(0, 0, 640, 480, 0, PlayerObject)

interactionDistance = 50;
inventory_rows = 1;
row_length = 12;
total_inventory = inventory_rows*row_length;
inventory = array_create(total_inventory); // Create a dictionary for the player inventory
for(_i = 0; _i < total_inventory; ++_i){
	inventory_slot = 
	{
		name : "",
		amount : 0,
		durability : 0,
	};
	inventory[_i] = inventory_slot;
}

function add_to_inventory(item) {
    for(_i = 0;_i<total_inventory; ++_i){
		if(inventory[_i].name == item.name && inventory[_i].amount < item.stack_size){
		inventory[_i].amount += 1;
		inventory[_i].durability = -1;
		show_debug_message("inventory slot; " + string(_i) + " item_name; " + inventory[_i].name + " durability; " + string(inventory[_i].durability) + " amount; " + string(inventory[_i].amount))
		return true;
		}
		else if(inventory[_i].name == ""){
		inventory[_i].name = item.name;
		inventory[_i].amount = 1;
		inventory[_i].durability = item.durability;
		show_debug_message("inventory slot; " + string(_i) + " item_name; " + inventory[_i].name + " durability; " + string(inventory[_i].durability) + " amount; " + string(inventory[_i].amount))
		return true;
		}
	}return false;
}

inventory_visible = false;

instance_create_layer(x,y,"EntityLayer",CameraObject);