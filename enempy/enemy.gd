extends CharacterBody2D

var position_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$speed.speed = 50
	pass # Replace with function body.

func set_entity_position(id, new_position):
	position_id = id
	set_position(new_position)

func action(entity_map):
	var self_unit = entity_map[position_id]
	for index in range(len(entity_map)):
		var unit = entity_map[index]
		if unit[1] != 0:
			continue
		
		if unit[0][0] > self_unit[0][0]:
			return ["MOVE", "RIGHT"]
		elif unit[0][1] > self_unit[0][1]:
			return ["MOVE", "DOWN"]
		
	return ["MOVE", "RIGHT"]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
