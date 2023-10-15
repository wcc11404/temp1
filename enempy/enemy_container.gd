extends Node2D
class_name emempy_container
@onready var enemy = preload("res://enempy/enemy.tscn")
var enemy_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_enemy():
	var map = get_tree().get_first_node_in_group("map")
	var random_position_id = map.get_random_position_id()
	if map.is_position_empty(random_position_id):
		var enemy_temp = enemy.instantiate()
		self.add_child(enemy_temp)
		
		enemy_temp.get_node("position").set_entity_position(random_position_id)
		enemy_list.append(enemy_temp)
		
		return true
	return false
	
func clean_enemy():
	var map = get_tree().get_first_node_in_group("map")
	for index in range(len(enemy_list) - 1, -1, -1):
		var enemy_entity = enemy_list[index]
		if not enemy_entity.get_node("health").is_alive():
			map.clean_entity(enemy_entity.get_node("position").position_id)
			enemy_list[index].queue_free()
			enemy_list.remove_at(index)
