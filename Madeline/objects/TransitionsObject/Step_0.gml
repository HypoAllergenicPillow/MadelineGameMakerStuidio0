if (place_meeting(x, y, PlayerObject)) // Move to the next room if we are not in the last room
{
	if(room != room_last){
	show_debug_message("Transition to next room");
	room_goto_next();
	PlayerObject.touch_spawn= true;
	}
	
}