var SpawnPoint = noone;
if(global.previous_room<=room){SpawnPoint = instance_find(SpawnObject, 0);}
else{SpawnPoint = instance_find(TransitionsObject, 0);}
if(SpawnPoint==noone){game_end(1);}
else{
instance_create_layer(SpawnPoint.x,SpawnPoint.y,"EntityLayer",PlayerObject);
}