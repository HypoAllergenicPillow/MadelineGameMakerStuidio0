horizontal_speed = 0;
vertical_speed = 0;
walk_speed = 4;
sprint_speed = 8;

//view_camera[0] = camera_create_view(0, 0, 640, 480, 0, PlayerObject)

touch_spawn = true;
previous_room = room_first;

inventory = ds_map_create(); // Create a dictionary for the player inventory
interactionDistance = 50;

function add_to_inventory(item) {
    if (ds_map_exists(inventory, item)) {
        var current_count = ds_map_find_value(inventory, item);
        ds_map_replace(inventory, item, current_count + 1); // Increment the count
    } else {
        ds_map_add(inventory, item, 1); // Add the item with a count of 1
    }
}

inventory_visible = false;