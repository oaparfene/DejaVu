extends KinematicBody2D

onready var partDirt = $partDirt
onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var bodyBullet_load = preload("res://bodyBullet.tscn")
var velocity = Vector2.ZERO

func _ready():
	timerAttack.wait_time = 1
	Globals.resetFuel()

func _physics_process(delta):
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	rotation = Globals.carVector.x/3
	
	if Globals.carFuel["current"] > 0:
		velocity.y = Globals.carVector.y*delta*Globals.carSpeed
		velocity.x = Globals.carVector.x*delta*Globals.carSteer
	else:
		velocity = Vector2(0,Globals.roadSpeed)*delta
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Lose" in kinCollisionInfo.collider.name:
			get_tree().change_scene("res://Garage.tscn")
	
	partTyre.emitting = Globals.carVector.y > 50
	Globals.changeFuel(-4*delta)
	sprBro.rotation = Globals.fireVector.angle()

func _on_timerAttack_timeout():
	if Globals.fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position + Globals.fireVector*100
		bodyBullet.rotation = Globals.fireVector.angle()
		bodyBullet.fireVector = Globals.fireVector
		bodyBullet.speed = 30
		get_parent().add_child(bodyBullet)
