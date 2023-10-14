extends CharacterBody2D

@onready var playerAni = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 行动策略
func action(entity_map):
	if not $health.is_alive():
		return ["NONE"]
	
	
		
	return ["ATTACK"]
	
# 攻击相关
func attack(entity):
	entity.attacked(self)
func attacked(entity):
	var result = $health.decrease_hp(entity.get_node("power").power_point)
