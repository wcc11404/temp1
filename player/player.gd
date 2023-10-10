extends CharacterBody2D

@onready var playerAni = $AnimatedSprite2D
var position_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_entity_position(id, new_position):
	position_id = id
	set_position(new_position)

func action(entity_map):
	return ["MOVE", "RIGHT"]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
