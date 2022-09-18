#MContainerBase
extends Node2D
class_name MContainerBase

export var offset_x = 44
export var offset_y = 44
export var offset_z = 0
export var extra_offset_x = 22
export var extra_offset_y = 22
export var size_x = 5
export var size_y = 5
export var size_z = 3
export var mask_file = ""

var box = []


func _ready():
	add_to_group(name)
	add_to_group("game")
	var Mask = FileReader.read(mask_file,null)
	box.resize(size_x)
	for i in range(size_x):
		box[i] = []
		box[i].resize(size_y)
		for j in range(size_y):
			box[i][j] = []
			box[i][j].resize(size_z)
			for k in range(size_z):
				if Mask == null or Mask[i][j] == 1:
					box[i][j][k] = add_tile(i,j,k,get_parent().distribute_face())
				else:
					box[i][j][k] = null
	
	for x in range(size_x):
		for y in range(size_y):
			for z in range(size_z):
				check_is_on_top(x,y,z)

func check_is_on_top(x,y,z):
	print("Not Defined")


func has_tile(x,y,z) -> bool:
	if x < size_x and y < size_y and z < size_z and box[x][y][z] is MTile:
		return true
	else:
		return false


func on_refresh():
	var children = get_children()
	for c in children:
		if(c is MTile):
			c.set_face_number(get_parent().redistribute_face())

func refresh_children(node:Node):
	if(node is MTile):
		node.set_face_number(get_parent().redistribute_face())
	var children = node.get_children()
	for c in children:
		refresh_children(c)

func add_tile(x,y,z,face_num):
	var tile = Constants.tile_scn.instance()
	tile.set_face_number(face_num)
	tile.z_index = z
	tile.location_x = x
	tile.location_y = y
	tile.location_z = z
	tile.set_container_name(name)
	add_child(tile)
	if z % 2 == 0:
		tile.global_position = global_position + Vector2(x * offset_x,y*offset_y)
	else:
		tile.global_position = global_position + Vector2(x * offset_x + extra_offset_x,y*offset_y + extra_offset_y)
	
	tile.global_position += Vector2(0,z*offset_z)
	
	return tile

func on_tile_popped(x,y,z):
	box[x][y][z] = null
	for x in range(size_x):
		for y in range(size_y):
			for z in range(size_z):
				check_is_on_top(x,y,z)
