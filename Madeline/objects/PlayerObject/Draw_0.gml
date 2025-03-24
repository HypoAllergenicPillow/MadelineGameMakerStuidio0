// Draw Event of obj_player
draw_self(); // Draw the player sprite

var nearestItem = instance_nearest(x, y, ItemObject);
if (nearestItem != noone && point_distance(x, y, nearestItem.x, nearestItem.y) <= interactionDistance) {
    draw_set_color(c_white); // Set text color to white
    draw_text(x, y - 30, "Press E to collect: " + nearestItem.name); // Adjusted to use item_name
}
