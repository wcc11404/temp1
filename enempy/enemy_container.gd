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

func add_enemy(enemy_map_index, enemy_position):
	var enemy_temp = enemy.instantiate()
	enemy_temp.get_node("position").set_entity_position(enemy_map_index, enemy_position)
	enemy_list.append(enemy_temp)
	
	self.add_child(enemy_temp)
	return enemy_temp

func clean_enemy(entity_map):
	for index in range(len(enemy_list) - 1, -1, -1):
		if enemy_list[index].get_node("health").health_point <= 0:
			entity_map[enemy_list[index].get_node("position").position_id][1] = null
			enemy_list[index].queue_free()
			enemy_list.remove_at(index)
