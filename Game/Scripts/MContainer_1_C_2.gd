#1 Cover 2
extends MContainerBase

func check_is_on_top(x,y,z):
	if has_tile(x,y,z):
		if z%2 == 0:
			if not has_tile(x,y,z + 1) and not has_tile(x - 1 ,y,z + 1):
				(box[x][y][z] as MTile).set_is_on_top(true)
		else:
			if not has_tile(x,y,z + 1) and not has_tile(x + 1 ,y,z + 1):
				(box[x][y][z] as MTile).set_is_on_top(true)

