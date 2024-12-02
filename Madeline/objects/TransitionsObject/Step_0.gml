	if (global.touch_transition == true && !place_meeting(x, y, PlayerObject)){
		global.touch_transition = false;
		show_debug_message("Unset touch_spawn flag");
	}
	else if (global.touch_transition == false && place_meeting(x, y, PlayerObject)) // Move to the previous room if we are not in first room
	{
		if(room != room_last){
			global.previous_room = room;
			global.touch_spawn = true;
			global.touch_transition = false;
			show_debug_message("Transition to next room");
			room_goto_next();
		}
	}
