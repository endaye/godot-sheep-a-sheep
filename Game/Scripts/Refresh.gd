extends Sprite

var counter = 0

func _ready():
	counter = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and  get_rect().has_point(to_local(event.position)):
		get_tree().call_group("game","shuffle_tiles")
		get_tree().call_group("game","on_refresh")
		counter += 1
		$Label.text = String(counter)
