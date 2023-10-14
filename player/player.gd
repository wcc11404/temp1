extends CharacterBody2D

@onready var playerAni = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 位置相关函数
var position_id = 0
func set_entity_position(id, new_position):
	position_id = id
	set_position(new_position)

# 行动策略
func action(entity_map):
	#return ["MOVE", "RIGHT"]
	return ["NONE"]
	

# 攻击相关
func attack():
	pass
