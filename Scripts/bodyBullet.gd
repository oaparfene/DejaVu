extends KinematicBody2D

var fireVector:Vector2
var speed:float
var mass:float

func _physics_process(delta):
	var kinCollisionInfo = move_and_collide(fireVector*speed*delta)
	if kinCollisionInfo:
		if not "Border" in kinCollisionInfo.collider.name:
			kinCollisionInfo.collider.damage(mass*speed)
		queue_free()
