extends Node2D

class_name health

@onready var hp_bar = $TextureProgressBar
var health_point = 10
var max_health_point = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.min_value = 0
	set_max_hp(3)
	set_hp(3)

func set_max_hp(num):
	max_health_point = num
	hp_bar.max_value=max_health_point
	
func set_hp(num):
	#var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	#tween.tween_property($TextureProgressBar, "value", num, 1)
	#tween.interpolate_value(hp_bar.value, num, 0.1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#tween.play()
	health_point = num
	hp_bar.value = health_point

func is_alive():
	if health_point <= 0:
		return false
	return true
	
func decrease_hp(num):
	if num <= 0:
		return false
	var temp_point = health_point
	temp_point -= num
	temp_point = max(temp_point, 0)
	set_hp(temp_point)
	return false

func increase_hp(num):
	if num <= 0:
		return false
	var temp_point = health_point
	temp_point += num
	temp_point = min(temp_point, max_health_point)
	set_hp(temp_point)
	return false
