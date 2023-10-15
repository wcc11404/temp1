extends Node2D

@onready var tilemap = $TileMap

# 全局地图信息
var entity_map = []
# 获取单元格中点的全局坐标
func get_map_position(id):
	return to_global(tilemap.map_to_local(get_id_position(id))) * tilemap.scale
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取所有有效单元格的位置， 获取玩家对象
	var bg1_cells = tilemap.get_used_cells(0)
	bg1_cells.sort()
	
	# 初始化 实体图层状态， null表示什么都没有， 0 表示玩家， 1 表示怪物
	for item in bg1_cells:
		var temp = [item, null]
		entity_map.append(temp)

func move_entity(source_position_id, target_position_id):
	set_entity(target_position_id, get_id_entity(source_position_id))
	clean_entity(source_position_id)
func set_entity(position_id, entity):
	entity_map[position_id][1] = entity
func clean_entity(position_id):
	entity_map[position_id][1] = null
func get_random_position_id():
	var ran = RandomNumberGenerator.new()
	var num = ran.randi_range(0, len(entity_map) - 1)
	return num
func is_position_empty(position_id):
	return entity_map[position_id][1] == null
func is_position_has_entity(position_id, entity_type):
	if entity_map[position_id][1] == null:
		return false
	return entity_map[position_id][1].entity_type == entity_type
func get_id_position(position_id):
	return entity_map[position_id][0]
func get_id_entity(position_id):
	return entity_map[position_id][1]

func _process(delta):
	pass
