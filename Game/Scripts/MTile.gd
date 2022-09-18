#MTile
extends Node2D
class_name MTile


export var face_number : int = -1 
export var is_on_top:bool = false
export var is_clickable:bool = true
export var is_on_table:bool = true

var is_gameover = false
var container_name:String = ""

var location_x = -1
var location_y = -1
var location_z = -1

func _ready():
	set_is_on_top(is_on_top)
	set_face_number(face_number)
	add_to_group("game")
	

func set_container_name(c_name):
	container_name = c_name

func get_container_name():
	return container_name


func set_face_number(number : int):
	face_number = number
	$NumberLabel.text = String(face_number)

func get_face_number():
	return face_number
	
func set_is_on_top(is_top:bool):
	is_on_top = is_top
	$GrayTile.visible = not is_on_top

func get_is_on_top():
	return is_on_top
	

func _input(event):
	if event is InputEventMouseButton and event.pressed and is_on_table and is_clickable and event.button_index == BUTTON_LEFT and get_is_on_top() and $ColorTile.get_rect().has_point($ColorTile.to_local(event.position)) and not is_gameover:
		_on_clikced()




func _on_tween_completed(object, key):
	get_tree().call_group("bottom_panel","_on_tile_received",face_number)
	get_tree().call_group("game","count_down",face_number)
	queue_free()
	
func on_gameover(is_over):
	is_gameover = is_over
	
func _on_clikced():
	if container_name != "":
		get_tree().call_group(container_name,"on_tile_popped",location_x,location_y,location_z)
	else:
		print("container_name is null")
	var size = get_viewport().size
	z_index = 100
	$Tween.interpolate_property(self,"global_position",global_position,Vector2(size.x*0.5,size.y - 40),0.3,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	


func on_refresh():
	if is_on_table:
		$AnimationPlayer.play("Shake")
		
