extends Node2D

@onready var tilemap = $TileMap
var bg1_cells = null
var entity_map = []
@onready var player = $player
@onready var enemy = $enemy
var entity_arr = [player, enemy]
var xingdong_arr = []

# 获取单元格中点的全局坐标
func get_map_position(id):
	return to_global(tilemap.map_to_local(bg1_cells[id])) * tilemap.scale
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取所有有效单元格的位置， 获取玩家对象
	bg1_cells = tilemap.get_used_cells(0)
	bg1_cells.sort()
	#player = get_tree().get_first_node_in_group("player")
	enemy = get_tree().get_first_node_in_group("enemy")
	#print(bg1_cells)
	
	# 初始化 实体图层状态， -1表示什么都没有， 0 表示玩家， 1 表示怪物
	entity_map.resize(bg1_cells.size())
	entity_map.fill(-1)
	
	# 初始化 玩家初始位置
	var player_map_index = 102
	entity_map[player_map_index] = 0
	var player_position = get_map_position(player_map_index)
	player.set_entity_position(player_position)
	#print(player_position)
	
	# 初始化 怪物初始位置
	var enemy_map_index = 15
	entity_map[enemy_map_index] = 1
	var enemy_position = get_map_position(enemy_map_index)
	enemy.set_entity_position(enemy_position)

func move_unit(entity, index, direct):
	var entity_position = bg1_cells[index]
	
	if direct == "UP":
		entity_position[1] -= 1
	elif direct == "DOWN":
		entity_position[1] += 1
	elif direct == "LEFT":
		entity_position[0] -= 1
	elif direct == "RIGHT":
		entity_position[0] += 1
	else:
		return
	
	for i in range(len(bg1_cells)):
		var item = bg1_cells[i]
		if entity_position[0] != item[0]:
			continue
		if entity_position[1] != item[1]:
			continue
		
		entity.set_entity_position(get_map_position(i))
		entity_map[i] = entity_map[index]
		entity_map[index] = -1
		break
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for entity in entity_arr:
		var can = entity.get_node("speed").xingdong()
		if can == true:
			xingdong_arr.append(entity)
	if xingdong_arr.size() > 0:
		xingdong()
		xingdong_arr.clear()
	#for index in range(len(bg1_cells)):
	#	if entity_map[index] == 0:
	#		move_unit(player, index, "RIGHT")
	#		player.get
	#	elif entity_map[index] == 1:
	#		move_unit(enemy, index, "RIGHT")
	
func xingdong():
	for entity in entity_arr:
		move_unit(entity, index, "RIGHT")
		
func random_generate_tilemap():
	
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
