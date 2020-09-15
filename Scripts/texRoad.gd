extends Node2D

func _physics_process(delta):
	position.y += delta*Globals.roadSpeed
	if position.y > 0:
		position.y -= 810
