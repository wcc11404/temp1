extends Node2D

class_name speed

var speed = 20
var xingdongtiao = 0
var max_xingdongtiao = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

func xingdong():
	xingdongtiao += speed
	if xingdongtiao >= max_xingdongtiao:
		return true
	return false

func next():
	xingdongtiao -= max_xingdongtiao
	xingdongtiao = min(xingdongtiao, 0)

func init():
	xingdongtiao = 0
