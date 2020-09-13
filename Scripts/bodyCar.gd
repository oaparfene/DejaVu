extends KinematicBody2D

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")
var velocity = Vector2.ZERO
var haveFuel = true

func _ready():
	timerAttack.wait_time = 0.3
	Globals.setCarVariables()
	Globals.resetFuel()
	Globals.resetInputs()
	$sprCar.texture = load("res://Assets/Cars/img_"+str(Globals.getCarName())+".png")

func _physics_process(delta):
	
	haveFuel = Globals.carFuel["current"] > 0
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	if haveFuel:
		velocity.y = Globals.carVector.y*delta*Globals.carSpeed*(1+int(velocity.y > 0)*0.40)
		velocity.x = Globals.carVector.x*delta*Globals.carSteer
	else:
		velocity = Vector2(0,Globals.roadSpeed*delta)
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Lose" in kinCollisionInfo.collider.name:
			var _currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")
			return
	
	sprBro.rotation = Globals.fireVector.angle() # Update bro's aiming position
	
	if haveFuel:
		rotation = Globals.carVector.x/3 # Handle rotation
		#partTyre.emitting = Globals.carVector.y > 0.6 # Handle tyre marks
		Globals.changeFuel(-4*delta) # Deplete fuel

func _on_timerAttack_timeout():
	if Globals.fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = Globals.fireVector.angle()
		bodyBullet.fireVector = Globals.fireVector
		bodyBullet.speed = 1600
		get_parent().add_child(bodyBullet)
