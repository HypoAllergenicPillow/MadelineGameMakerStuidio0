if (place_meeting(x, y, PlayerObject)) {
    // Only allow teleport if the player is NOT touching the spawn point
    if (!PlayerObject.touch_spawn) {
        PlayerObject.touch_spawn = true; // Set the touching flag

        // Teleport logic
		PlayerObject.previous_room = room;
        if (room != room_first) {
            room_goto_previous(); // Go to room 0 if this is the last room
        }
    }
} else {
    // Reset the touching flag if the player is no longer touching the spawn point
    PlayerObject.touch_spawn = false;
}