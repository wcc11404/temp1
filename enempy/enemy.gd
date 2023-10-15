extends CharacterBody2D

class_name enemy

var entity_type = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$speed.speed = 50

func action():
	if not $health.is_alive():
		return ["NONE"]
	
	var map = get_tree().get_first_node_in_group("map")
	# 找玩家
	var player_position_id = $position.find_nearest_player_position()
	var player_position = map.get_id_position(player_position_id)
	
	# 判断与玩家的距离
	var distance = $position.get_entity_distance(player_position)
	
	# 如果距离大于1
	if distance > 1:
		# 找玩家身边的目标点
		var target_position = $position.find_target_nearest_position(player_position)
		
		# 寻路
		var direction = $position.find_next_direction(target_position)
		if direction != "NONE":
			return ["MOVE", direction]
		
	return ["NONE"]
	
func attack(entity):
	entity.attacked(self)
func attacked(entity):
	var result = $health.decrease_hp(entity.get_node("power").power_point)
