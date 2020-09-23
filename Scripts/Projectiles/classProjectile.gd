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

func setCollision(team):
	set_collision_layer_bit(Globals.projectileBits[type],true)
	for otherTeam in Globals.teamBits:
		if otherTeam != team:
			set_collision_mask_bit(Globals.teamBits[otherTeam],true)
