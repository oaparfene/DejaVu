extends KinematicBody2D

var fireVector:Vector2
var speed:float
var mass:float
var type:String

func _physics_process(delta):
	var kinCollisionInfo = move_and_collide(fireVector*speed*delta)
	if kinCollisionInfo:
		if not "Border" in kinCollisionInfo.collider.name:
			call("impact",kinCollisionInfo)
		queue_free()
