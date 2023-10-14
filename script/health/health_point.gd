extends Node2D

class_name health_point

var hp = 10
var max_hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setMax_hp(num):
	max_hp = num
	init_hp()
	
func init_hp():
	hp = max_hp

func decrease_hp(num):
	if num <= 0:
		return false
	hp -= num
	hp = max(hp, 0)
	if hp == 0:
		return true
	return false

func increase_hp(num):
	if num <= 0:
		return false
	hp += num
	hp = min(hp, max_hp)
	return false
