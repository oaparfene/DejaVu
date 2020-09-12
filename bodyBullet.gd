extends KinematicBody2D

var fireVector = Vector2.ZERO
var speed = 0

func _physics_process(delta):
	var kinCollisionInfo = move_and_collide(fireVector*speed)
	if kinCollisionInfo:
		if "Border" in kinCollisionInfo.collider.name:
			queue_free()
