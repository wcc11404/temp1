extends Node2D

class_name position

var position_id = 0
func set_entity_position(id, new_position):
	position_id = id
	get_parent().set_position(new_position)

func get_entity_distance(target_position,entity_map):
	var self_position = entity_map[position_id][0]
	var delta_x = abs(target_position[0] - self_position[0])
	var delta_y = abs(target_position[1] - self_position[1])
	return delta_x + delta_y
	
func find_nearest_entity_position(entity_type, entity_map):
	var self_position = entity_map[position_id][0]
	var target_position_id = position_id
	var min_distance = 99
	for index in range(len(entity_map)):
		var item = entity_map[index]
		if item[1] == null or item[1].entity_type != entity_type:
			continue
		var distance = get_entity_distance(item[0], entity_map)
		if distance < min_distance:
			min_distance = distance
			target_position_id = index
	return target_position_id

func find_nearest_player_position(entity_map):
	# 找玩家 并 初始化dict
	for index in range(len(entity_map)):
		var item = entity_map[index]
		if item[1] != null and item[1].entity_type == 0:
			return index
	return 0
	
func find_target_nearest_position(target_position, entity_map):
	# 初始化dict
	var map_dict = {}
	var self_position = entity_map[position_id][0]
	for item in entity_map:
		map_dict[item[0]] = item[1]
	
	# 找目标点
	var near_position_list = [Vector2i(-1, 0), Vector2i(+1, 0), Vector2i(0, -1), Vector2i(0, +1)]
	var nearest_position = target_position
	var min_distance = 99
	for item in near_position_list:
		var new_position = Vector2i(target_position[0] + item[0], target_position[1] + item[1])
		if map_dict.has(new_position) and map_dict[new_position] == null:
			var distance = get_entity_distance(new_position, entity_map)
			if distance < min_distance:
				min_distance = distance
				nearest_position = new_position
		
	return nearest_position

func find_next_direction(target_position, entity_map):
	var self_position = entity_map[position_id][0]
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
