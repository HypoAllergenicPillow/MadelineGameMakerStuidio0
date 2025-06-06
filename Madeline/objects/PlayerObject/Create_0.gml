

inventory_display = instance_create_layer(0,0,"UI",Obj_Inventory,{parent : id});
instance_deactivate_object(inventory_display);

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
for(i=0;i<total_inventory;++i){inventory[i]=instance_create_layer(0,0,"UI",SlotObject);}
inventory_swap_object = {slot:instance_create_layer(0,0,"UI",SlotObject),origonal_slot:-1};

function add_to_inventory(item) {
	if(object_get_parent(item.object_index) == ItemObject){
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
	}else{
		for(i = 0;i<total_inventory;i++){
			if(item.name==inventory[i].name&&inventory[i].amount<inventory[i].stack_size){
				if(item.amount + inventory[i].amount <= item.stack_size){
					inventory[i].name = item.name;
					inventory[i].amount = item.amount+inventory[i].amount;
					inventory[i].durability = item.durability;
					inventory[i].max_durability = inventory[i].max_durability;
					inventory[i].stack_size = item.stack_size;
					return true;
				}else{
					item.amount -= inventory[i].stack_size-inventory[i].amount;
					inventory[i].amount=inventory[i].stack_size;
					return add_to_inventory(item)
				}
			}else if(inventory[i].name == ""){
				show_debug_message(item.name);
				inventory[i].name = item.name;
				inventory[i].amount = item.amount;
				inventory[i].durability = item.durability;
				inventory[i].max_durability = item.max_durability;
				inventory[i].stack_size = item.stack_size;
				return true;
			}
		}return false;
		// Loop through inventory
		// Add however much can fit
		// If not all can fit, search for another spot
		// Lastly, if no spot already holds this object, use empty slot
	}
}

inventory_visible = false;


instance_create_layer(x,y,"EntityLayer",CameraObject);