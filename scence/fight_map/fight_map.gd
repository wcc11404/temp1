extends Node2D

@onready var tilemap = $TileMap
var entity_map = [null]

# Called when the node enters the scene tree for the first time.
func _ready():
	entity_map.resize(tilemap.get_used_cells(0).size())
	entity_map.fill(-1)
	print(entity_map)
	random_generate_tilemap()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random_generate_tilemap():
	var bg1_cells = tilemap.get_used_cells(0)
	print(bg1_cells)
	print(bg1_cells[-1])
	
	var result = tilemap.map_to_local(bg1_cells[-1])
	print(result)
	result = to_global(result)
	print(result)
	
	var position = Vector2.ZERO
	position.x = 248
	position.y = 184
	var temp = tilemap.cell_quadrant_size
	print(tilemap.global_position)

	pass
