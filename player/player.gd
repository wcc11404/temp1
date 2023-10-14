extends CharacterBody2D

class_name player
@onready var playerAni = $AnimatedSprite2D

var entity_type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 行动策略
func action(entity_map):
	if not $health.is_alive():
		return ["NONE"]
	
	# 找最近的敌人
	var enemy_position_id = $position.find_nearest_entity_position(1, entity_map)
	var enemy_position = entity_map[enemy_position_id][0]
	var target_enemy = entity_map[enemy_position_id][1]
	
	# 判断与敌人的距离
	var distance = $position.get_entity_distance(enemy_position, entity_map)
	if distance == 1:
		return ["ATTACK", target_enemy]
		pass
		
	return ["NONE"]
	
# 攻击相关
func attack(entity):
	entity.attacked(self)
func attacked(entity):
	var result = $health.decrease_hp(entity.get_node("power").power_point)
