extends Node2D

@onready var map = preload("res://scence/fight_map/fight_map.tscn").instantiate()
@onready var player = $player
@onready var entity_arr = [player]
@onready var enemy_container = $enmey_container
var act_entity_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# 初始化地图
	self.add_child(map)
	map.add_to_group("map")
	
	# 初始化 玩家初始位置
	var player_map_index = 102
	player.get_node("position").set_entity_position(player_map_index)

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
	enemy_container.clean_enemy()

func move_unit(entity, direct):
	var index = entity.get_node("position").position_id
	var entity_position = map.get_id_position(index)
	
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
	
	for i in range(len(map.entity_map)):
		var item_position = map.get_id_position(i)
		if entity_position[0] != item_position[0]:
			continue
		if entity_position[1] != item_position[1]:
			continue
		
		# 地图有人了
		if not map.is_position_empty(i):
			return false
			
		entity.get_node("position").set_entity_position(i)
		map.move_entity(index, i)
		return true
	return false

# 所有实体行动逻辑
func take_action():
	for entity in act_entity_array:
		var next_act = entity.action()
		if next_act[0] == "MOVE":
			move_unit(entity, next_act[1])
		elif next_act[0] == "ATTACK":
			entity.attack(next_act[1])
		elif next_act[0] == "NONE":
			pass
		else:
			pass
		entity.get_node("speed").next_turn()

func _on_enemy_generator_timer_timeout():
	if enemy_container.enemy_list.size() < 10:
		enemy_container.add_enemy()
