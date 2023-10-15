extends Node2D

class_name experience
signal lvl_up_signal(lvl)

var lvl = 1
var experience_point = 0
var max_experience_point = 10
var killed_exp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lvl(1)

func set_max_exp(num):
	max_experience_point = num
func set_exp(num):
	experience_point = num
func set_lvl(num):
	lvl = num
func increase_exp(num):
	if num <= 0:
		return false
	set_exp(experience_point + num)
	while experience_point >= max_experience_point:
		lvl_up()
	return false
func lvl_up():
	set_lvl(lvl + 1)
	set_exp(experience_point - max_experience_point)
	emit_signal("lvl_up_signal", lvl)
