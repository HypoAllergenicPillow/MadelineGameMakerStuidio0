var spawnPoint = instance_find(SpawnObject,0);
if(spawnPoint!=noone){
	PlayerObject.x=spawnPoint.x;
	PlayerObject.y=spawnPoint.y;
}else show_error("SpawnPoint not found in Room2",true);