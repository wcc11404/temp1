extends Node2D

class_name speed

var speed = 20
var tick_measure = 0
var max_tick_measure = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

func tick():
	tick_measure += speed
	if tick_measure >= max_tick_measure:
		return true
	return false

func next_turn():
	tick_measure -= max_tick_measure
	tick_measure = min(tick_measure, 0)

func init():
	tick_measure = 0
