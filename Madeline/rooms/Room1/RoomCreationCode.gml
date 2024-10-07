if(PlayerObject.prevois_room < room)//Go to spawn in next room
{
var spawnPoint = instance_find(SpawnObject,0);
if(spawnPoint!=noone){
	PlayerObject.x=spawnPoint.x;
	PlayerObject.y=spawnPoint.y;
}else show_error("SpawnPoint not found in Room1",true);	
}else//go to transion point in previous room
{
	var transitionPoint = instance_find(TransitionsObject,0);
if(transitionPoint!=noone){
	PlayerObject.x=transitionPoint.x;
	PlayerObject.y=transitionPoint.y;
}else show_error("transitionPoint not found in Room1",true);
}



	