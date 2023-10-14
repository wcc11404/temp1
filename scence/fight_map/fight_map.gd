extends Node2D

@onready var tilemap = $TileMap
@onready var player = $player
@onready var entity_arr = [player]
@onready var enemy_container = $enemy_container

# 全局地图信息
var entity_map = []
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
	
	# 初始化 玩家初始位置
	var player_map_index = 102
	entity_map[player_map_index][1] = 0
	var player_position = get_map_position(player_map_index)
	player.get_node("position").set_entity_position(player_map_index, player_position)
	
func move_unit(entity, direct):
	var index = entity.get_node("position").position_id
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
			
		entity.get_node("position").set_entity_position(i, get_map_position(i))
		entity_map[i][1] = entity_map[index][1]
		entity_map[index][1] = -1
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 游戏帧
func _on_actor_timer_timeout():
	tick()
func tick():
	# 遍历玩家策略帧
	for entity in entity_arr:
		var can_act = entity.get_node("speed").tick()
		if can_act == true:
			act_entity_array.append(entity)
	
	# 遍历怪物策略帧
	for entity in enemy_container.enemy_list:
		var can_act = entity.get_node("speed").tick()
		if can_act == true:
			act_entity_array.append(entity)
	
	# 行动
	if act_entity_array.size() > 0:
		take_action()
		act_entity_array.clear()
	
	# 清理死去的怪物
	enemy_container.clean_enemy(entity_map)

# 所有实体行动逻辑
func take_action():
	for entity in act_entity_array:
		var next_act = entity.action(entity_map)
		if next_act[0] == "MOVE":
			move_unit(entity, next_act[1])
		elif next_act[0] == "ATTACK":
			entity.attack(enemy_container.enemy_list[0])
		elif next_act[0] == "NONE":
			pass
		else:
			pass
		entity.get_node("speed").next_turn()

# 地图怪物生成
func add_enemy(add_map_index):
	entity_map[add_map_index][1] = 1
	enemy_container.add_enemy(add_map_index, get_map_position(add_map_index))
func _on_enemy_generator_timer_timeout():
	if enemy_container.enemy_list.size() < 10:
		var ran = RandomNumberGenerator.new()
		var num = ran.randi_range(0, len(entity_map) - 1)
		if entity_map[num][1] == -1:
			add_enemy(num)


