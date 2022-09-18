extends Panel

func _ready():
	add_to_group("game")


func on_gameover(over):
	visible = over
