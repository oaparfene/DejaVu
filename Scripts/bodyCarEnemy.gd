extends KinematicBody2D

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")
var velocity = Vector2.ZERO
var haveFuel = true

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	#haveFuel = Globals.carFuel["current"] > 0
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	if haveFuel:
		velocity.y = Globals.carVector.y*delta*Globals.carSpeed*(1+int(velocity.y > 0)*0.40)
		velocity.x = Globals.carVector.x*delta*Globals.carSteer
	else:
		velocity = Vector2(0,Globals.roadSpeed*delta)
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Player" in kinCollisionInfo.collider.name:
			queue_free()
			return
	
	sprBro.rotation = Globals.fireVector.angle() # Update bro's aiming position
	
	if haveFuel:
		rotation = Globals.carVector.x/3 # Handle rotation
		
