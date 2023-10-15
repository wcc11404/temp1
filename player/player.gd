extends CharacterBody2D

class_name player
@onready var playerAni = $AnimatedSprite2D

var entity_type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 行动策略
func action():
	if not $health.is_alive():
		return ["NONE"]
	
	var map = get_tree().get_first_node_in_group("map")
	# 找最近的敌人
	var enemy_position_id = $position.find_nearest_entity_position(1)
	var enemy_position = map.get_id_position(enemy_position_id)
	var target_enemy = map.get_id_entity(enemy_position_id)
	
	# 判断与敌人的距离
	var distance = $position.get_entity_distance(enemy_position)
	if distance == 1:
		return ["ATTACK", target_enemy]
		pass
		
	return ["NONE"]
	
# 攻击相关
func attack(entity):
	entity.attacked(self)
func attacked(entity):
	var result = $health.decrease_hp(entity.get_node("power").power_point)
