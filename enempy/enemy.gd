extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$speed.speed = 50
	pass # Replace with function body.

func action(entity_map):
	if not $health.is_alive():
		return ["NONE"]
	
	# 找玩家身边的目标点
	var target_position = $position.find_nearest_player_position(entity_map)
	
	
	# 寻路
	var self_position = entity_map[$position.position_id][0]
	var direction = $position.find_next_direction(self_position, target_position)
	if direction != "NONE":
		return ["MOVE", direction]
		
	return ["NONE"]
	
func attack(entity):
	entity.attacked(self)
func attacked(entity):
	var result = $health.decrease_hp(entity.get_node("power").power_point)
