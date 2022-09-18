#1 Cover 1
extends MContainerBase

func check_is_on_top(x,y,z):
	if has_tile(x,y,z):
		if not has_tile(x,y,z + 1) :
				(box[x][y][z] as MTile).set_is_on_top(true)

