extends "res://Scripts/classCar.gd"

var state

var velocity = Vector2.ZERO

var carVector = Vector2.ZERO
var fireVector = Vector2.ZERO
var fire = false

func _ready():
	carName = "bad"
	maxHealth = 100
	health = maxHealth
	speed = 300
	steer = 100
	armor = 0
	state = "maintain"

func _physics_process(delta):
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	AI.getBehaviour(state,self)
	
	velocity = carVector*speed*delta
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Player" in kinCollisionInfo.collider.name:
			queue_free()
			return
		elif "Enemy" in kinCollisionInfo.collider.name:
			print("enemy to enemy collision")
			pass
	
	sprBro.rotation = Globals.fireVector.angle() # Update bro's aiming position


func _on_timerState_timeout():
	state = AI.getNewState(state)
	print(name," is now is state: ",state)


func _on_timerAttack_timeout():
	if fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = fireVector.angle()
		bodyBullet.fireVector = fireVector
		bodyBullet.speed = 1600
		bodyBullet.set_collision_mask_bit(1,true)
		get_parent().add_child(bodyBullet)
