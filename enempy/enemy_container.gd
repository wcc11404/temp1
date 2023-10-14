extends Node2D

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
	enemy_temp.set_entity_position(enemy_map_index, enemy_position)
	enemy_list.append(enemy_temp)
	
	self.add_child(enemy_temp)
