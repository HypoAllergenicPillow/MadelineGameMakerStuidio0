	if (!place_meeting(x, y, PlayerObject) && PlayerObject.touch_spawn == true)
	{
		PlayerObject.touch_spawn = false;
		show_debug_message("Unset touch_spawn flag");
	}
	else if (place_meeting(x, y, PlayerObject) && PlayerObject.touch_spawn == false) // Move to the previous room if we are not in first room
	{
		if(room != room_first){
			show_debug_message("Transition to previous room");
			room_goto_previous();
			PlayerObject.touch_spawn= true;
		}
		
	}
