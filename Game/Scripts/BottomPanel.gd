#BottomPanel
extends Node2D

export var icon_array = []
var tile_arrary = []

func _ready():
	add_to_group("bottom_panel")
	refresh()
	
	
func _on_tile_received(number):
	var i = tile_arrary.find(number)
	var j = tile_arrary.find_last(number)
	

	if i != j:
		tile_arrary.erase(number)
		tile_arrary.erase(number)
	else:
		tile_arrary.append(number)
		tile_arrary.sort()
	refresh()


func refresh():
	for i in 7:
		var icon = get_node(icon_array[i])
		icon.visible = (i < tile_arrary.size())
		if i < tile_arrary.size():
			icon.set_face_number(tile_arrary[i])
	if tile_arrary.size() > 7:
		print("Game Over")
		get_tree().call_group("game","on_gameover",true)
