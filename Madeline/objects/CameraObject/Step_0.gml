if(current_room!=room){
x=follow_target.x;
y=follow_target.y;
}
x_to=abs(follow_target.x-x)>jittermantissa?follow_target.x:x_to;
y_to=abs(follow_target.y-y)>jittermantissa?follow_target.y:y_to;
x+=(x_to-x)/camera_speed;
y+=(y_to-y)/camera_speed;
camera_set_view_pos(view_camera[0],x-(camera_width/2),y-(camera_height/2));