extends Node2D

@onready var tilemap = $TileMap
var entity_map = []
@onready var player = $player
@onready var enemy = $enemy
@onready var entity_arr = [player, enemy]
var act_entity_array = []

# 获取单元格中点的全局坐标
func get_map_position(id):
	
	return to_global(tilemap.map_to_local(entity_map[id][0])) * tilemap.scale
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取所有有效单元格的位置， 获取玩家对象
	var bg1_cells = tilemap.get_used_cells(0)
	bg1_cells.sort()
	#player = get_tree().get_first_node_in_group("player")
	#enemy = get_tree().get_first_node_in_group("enemy")
	
	# 初始化 实体图层状态， -1表示什么都没有， 0 表示玩家， 1 表示怪物
	for item in bg1_cells:
		var temp = [item, -1]
		entity_map.append(temp)
	#print(entity_map)
	
	# 初始化 玩家初始位置
	var player_map_index = 102
	entity_map[player_map_index][1] = 0
	var player_position = get_map_position(player_map_index)
	player.set_entity_position(player_map_index, player_position)
	
	# 初始化 怪物初始位置
	var enemy_map_index = 15
	entity_map[enemy_map_index][1] = 1
	var enemy_position = get_map_position(enemy_map_index)
	enemy.set_entity_position(enemy_map_index, enemy_position)

func move_unit(entity, direct):
	var index = entity.position_id
	var entity_position = entity_map[index][0]
	
	if direct == "UP":
		entity_position[1] -= 1
	elif direct == "DOWN":
		entity_position[1] += 1
	elif direct == "LEFT":
		entity_position[0] -= 1
	elif direct == "RIGHT":
		entity_position[0] += 1
	else:
		return false
	
	for i in range(len(entity_map)):
		var item = entity_map[i]
		if entity_position[0] != item[0][0]:
			continue
		if entity_position[1] != item[0][1]:
			continue
		
		# 地图有人了
		if item[1] != -1:
			return false
			
		entity.set_entity_position(i, get_map_position(i))
		entity_map[i][1] = entity_map[index][1]
		entity_map[index][1] = -1
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick()
	
func tick():
	for entity in entity_arr:
		var can_act = entity.get_node("speed").tick()
		if can_act == true:
			act_entity_array.append(entity)
	if act_entity_array.size() > 0:
		take_action()
		act_entity_array.clear()
		
func take_action():
	for entity in act_entity_array:
		var next_act = entity.action(entity_map)
		if next_act[0] == "MOVE":
			move_unit(entity, next_act[1])
		elif next_act[0] == "NONE":
			pass
		else:
			pass
		entity.get_node("speed").next_turn()
