#Level
extends Node


#var counter:int = 0
var tiles = []
export var initial_tiles = {
	0:10,
	1:10,
	2:10,
	3:10,
	4:10,
	5:10,
	6:10,
	7:10,
	8:10,
	9:10,
	10:10,
	11:10,
	12:10,
	13:10,
	14:10,
	15:10
}

func _init():
	for key in initial_tiles:
		var num = initial_tiles[key]*3
		for i in range(0,num):
			tiles.append(key)
	tiles.shuffle()

func _ready():
	add_to_group("game")
	$CounterLabel.text = String(tiles.size())
	
func distribute_face() -> int:
	var face = -1
	if tiles.size() > 0:
		face = tiles.pop_front()
	return face

var tiles_index = -1

func redistribute_face() -> int:
	tiles_index += 1
	return tiles[tiles_index]

func count_down(num):
	tiles.erase(num)
	$CounterLabel.text = String(tiles.size())
	if tiles.size() == 0:
		get_tree().call_group("game","on_game_win")

func shuffle_tiles():
	tiles.shuffle()
	tiles_index = -1
