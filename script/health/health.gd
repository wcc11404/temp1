extends Node2D

class_name health

var health_point = 2
var max_health_point = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setMax_hp(num):
	max_health_point = num
	init_hp()
	
func init_hp():
	health_point = max_health_point

func is_alive():
	if health_point <= 0:
		return false
	return true
	
func decrease_hp(num):
	if num <= 0:
		return false
	health_point -= num
	health_point = max(health_point, 0)
	if health_point == 0:
		return true
	return false

func increase_hp(num):
	if num <= 0:
		return false
	health_point += num
	health_point = min(health_point, max_health_point)
	return false
