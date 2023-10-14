extends Node2D

class_name position

var position_id = 0
func set_entity_position(id, new_position):
	position_id = id
	get_parent().set_position(new_position)

func find_nearest_player_position(entity_map):
	# 找玩家 并 初始化dict
	var map_dict = {}
	var player_position = Vector2i(0, 0)	
	for item in entity_map:
		if item[1] == 0:
			player_position = item[0]
		map_dict[item[0]] = item[1]
	
	# 找目标点
	var target_position = player_position
	var player_left_position = Vector2i(player_position[0] - 1, player_position[1])
	var player_right_position = Vector2i(player_position[0] + 1, player_position[1])
	var player_up_position = Vector2i(player_position[0], player_position[1] - 1)
	var player_down_position = Vector2i(player_position[0], player_position[1] + 1)
	if map_dict.has(player_left_position) and map_dict[player_left_position] == -1:
		target_position = player_left_position
	elif map_dict.has(player_right_position) and map_dict[player_right_position] == -1:
		target_position = player_right_position
	elif map_dict.has(player_up_position) and map_dict[player_up_position] == -1:
		target_position = player_up_position
	elif map_dict.has(player_down_position) and map_dict[player_down_position] == -1:
		target_position = player_down_position
		
	return target_position

func find_next_direction(self_position, target_position):
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
