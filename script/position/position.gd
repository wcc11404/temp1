extends Node2D

class_name position

var position_id = 0
func set_entity_position(id):
	position_id = id
	var map = get_tree().get_first_node_in_group("map")
	map.set_entity(position_id, get_parent())
	get_parent().set_position(map.get_map_position(position_id))
	
func get_entity_distance(target_position):
	var map = get_tree().get_first_node_in_group("map")
	var self_position = map.get_id_position(position_id)
	var delta_x = abs(target_position[0] - self_position[0])
	var delta_y = abs(target_position[1] - self_position[1])
	return delta_x + delta_y
	
func find_nearest_entity_position(entity_type):
	var map = get_tree().get_first_node_in_group("map")
	var target_position_id = position_id
	var min_distance = 99
	for index in range(len(map.entity_map)):
		var item_position = map.get_id_position(index)
		if map.is_position_empty(index) or not map.is_position_has_entity(index, 1):
			continue
		var distance = get_entity_distance(item_position)
		if distance < min_distance:
			min_distance = distance
			target_position_id = index
	return target_position_id

func find_nearest_player_position():
	var map = get_tree().get_first_node_in_group("map")
	# 找玩家
	for index in range(len(map.entity_map)):
		if map.is_position_has_entity(index, 0):
			return index
	return 0
	
func find_target_nearest_position(target_position):
	var map = get_tree().get_first_node_in_group("map")
	
	# 初始化dict
	var map_dict = {}
	for index in range(len(map.entity_map)):
		map_dict[map.get_id_position(index)] = map.get_id_entity(index)
	
	# 找目标点
	var near_position_list = [Vector2i(0, -1), Vector2i(0, +1), Vector2i(-1, 0), Vector2i(+1, 0)]
	var nearest_position = target_position
	var min_distance = 99
	for item in near_position_list:
		var new_position = Vector2i(target_position[0] + item[0], target_position[1] + item[1])
		if map_dict.has(new_position) and map_dict[new_position] == null:
			var distance = get_entity_distance(new_position)
			if distance < min_distance:
				min_distance = distance
				nearest_position = new_position
				
	return nearest_position

func find_next_direction(target_position):
	var map = get_tree().get_first_node_in_group("map")
	var self_position = map.get_id_position(position_id)
	# 寻路
	var delta_x = abs(self_position[0] - target_position[0])
	var delta_y = abs(self_position[1] - target_position[1])
	if delta_x == 0 and delta_y != 0:
		if self_position[1] > target_position[1]:
			return "UP"
		else:
			return "DOWN"
	elif delta_y == 0 and delta_x != 0:
		if self_position[0] > target_position[0]:
			return "LEFT"
		else:
			return "RIGHT"
	elif delta_x <= delta_y:
		if self_position[0] > target_position[0]:
			return "LEFT"
		else:
			return "RIGHT"
	elif delta_y < delta_x:
		if self_position[1] > target_position[1]:
			return "UP"
		else:
			return "DOWN"
	
	return "NONE"

func move(direct):
	var map = get_tree().get_first_node_in_group("map")
	var entity_position = map.get_id_position(position_id)
	
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
		
		map.clean_entity(position_id)
		set_entity_position(i)
		return true
	return false
