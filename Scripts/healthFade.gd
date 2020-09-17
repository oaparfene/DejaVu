extends ColorRect


func _physics_process(delta):
	rect_position.y += delta*800
	modulate.a -= 5*delta
	if modulate.a <= 0:
		queue_free()
