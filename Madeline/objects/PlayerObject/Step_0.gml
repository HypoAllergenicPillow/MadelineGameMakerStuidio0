#macro KEY_LEFT keyboard_check(ord("A"))
#macro KEY_RIGHT keyboard_check(ord("D"))
#macro KEY_UP keyboard_check(ord("W"))
#macro KEY_DOWN keyboard_check(ord("S"))
#macro KEY_SPRINT keyboard_check(vk_lshift)

#macro KEY_INTERACT keyboard_check(ord("E"))
var key_interact_name = "E";

#macro KEY_INVENTORY vk_tab
if(keyboard_check_pressed(KEY_INVENTORY)){
inventory_visible = !inventory_visible;
}

var _move_speed = KEY_SPRINT == 1 ? sprint_speed : walk_speed;

var _horizontal_direction = KEY_RIGHT - KEY_LEFT;
var _vertical_direction = KEY_DOWN - KEY_UP;

var _horizontal_change = _move_speed*_horizontal_direction;
var _vertical_change = _move_speed*_vertical_direction;

if (!place_meeting(x + _horizontal_change, y, ColisionObjects))
{
	x += _horizontal_change;
}
if (!place_meeting(x, y + _vertical_change, ColisionObjects))
{
y+= _vertical_change;
}

// Overworld Item Interaction

// Step Event of obj_player

var nearestItem = instance_nearest(x, y, ItemObjects);
if (nearestItem != noone) { // Item found
    if (point_distance(x, y, nearestItem.x, nearestItem.y) <= interactionDistance) {
        // Check for interaction
        if (KEY_INTERACT) {
			if(add_to_inventory(nearestItem)){
			// Use item_name from Create Event)
            instance_destroy(nearestItem); // Remove the item
			
			}
        }
    }
}