function instance_reset(){
name = "";
amount = 0;
durability = 0;
}
function copy(other_object){
name = other_object.name;
amount =  other_object.amount;
durability = other_object.durability;
}