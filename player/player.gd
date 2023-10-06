extends CharacterBody2D

@onready var playerAni = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var dir = Vector2.ZERO
var speed = 700

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var self_pos = position
	

	position.x = 248*6
	position.y = 184*6
	to_local(self_pos)
	#to_global(self_pos)
	#set_position(self_pos)
	
	#dir = (mouse_pos - self_pos).normalized()
	
	#velocity.x = 248
	#velocity.y = 184
	#print(velocity) -187 -674
	
	#move_and_slide()
	pass
