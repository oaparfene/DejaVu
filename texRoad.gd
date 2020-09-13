extends TextureRect

func _physics_process(delta):
	rect_position.y += delta*Globals.roadSpeed
	if rect_position.y > 0:
		rect_position.y -= 2430
