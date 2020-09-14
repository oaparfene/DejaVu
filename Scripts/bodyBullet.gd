extends KinematicBody2D

var fireVector = Vector2.ZERO
var speed = 0
var mass = 0.01

func _physics_process(delta):
	var kinCollisionInfo = move_and_collide(fireVector*speed*delta)
	if kinCollisionInfo:
		if "Car" in kinCollisionInfo.collider.name:
			kinCollisionInfo.collider.damage(mass*speed)
		queue_free()
