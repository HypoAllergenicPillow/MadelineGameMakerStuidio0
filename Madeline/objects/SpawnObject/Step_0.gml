	if (global.touch_spawn == true && !place_meeting(x, y, PlayerObject)){
		global.touch_spawn = false;
		show_debug_message("Unset touch_spawn flag");
	}
	else if (global.touch_spawn == false && place_meeting(x, y, PlayerObject)) // Move to the previous room if we are not in first room
	{
		if(room != room_first){
			global.previous_room = room;
			global.touch_spawn = false;
			global.touch_transition = true;
			show_debug_message("Transition to previous room");
			room_goto_previous();
		}
	}
