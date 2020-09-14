extends KinematicBody2D

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var ai_mode = 1

var rng = RandomNumberGenerator.new()

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")
var velocity = Vector2.ZERO
var haveFuel = true

func _ready():
	rng.randomize()
	ai_mode = rng.randi_range(1, 4)
	pass # Replace with function body.


func _physics_process(delta):
	
	#haveFuel = Globals.carFuel["current"] > 0
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	if haveFuel:
		rotation = AI.get_carVector(ai_mode, position).x/3 # Handle rotation
	
	if haveFuel:
		velocity.y = AI.get_carVector(ai_mode, position).y*delta*Globals.carSpeed*(1+int(velocity.y > 0)*0.40)
		velocity.x = AI.get_carVector(ai_mode, position).x*delta*Globals.carSteer
	else:
		velocity = Vector2(0,Globals.roadSpeed*delta)
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Player" in kinCollisionInfo.collider.name:
			queue_free()
			return
		elif "Enemy" in kinCollisionInfo.collider.name:
			print("enemy to enemy collision")
			pass
	
	sprBro.rotation = Globals.fireVector.angle() # Update bro's aiming position
	
	
		
