function instance_reset(){
name = "";
amount = 0;
durability = -1;
}
//ATTENTION set_sprite uses name variable which expects name to be something like "rockSprite"
function set_sprite(){
sprite_index = asset_get_index(name);
}

function clear_sprite(){
sprite_index = -1;
}