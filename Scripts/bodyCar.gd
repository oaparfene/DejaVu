extends "res://Scripts/classCar.gd"

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var haveFuel = true

func _ready():
	timerAttack.wait_time = 0.3
	var carData = Globals.getCarVariables()
	for variable in carData:
		set(variable,carData[variable])
	health = maxHealth
	mass *= 1 + float(armor)/100
	Globals.resetInputs()
	$sprCar.texture = load("res://Assets/Cars/img_"+carName+".png")
	team = "player"

func _physics_process(delta):
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	actVector += (Globals.carVector-actVector)*delta*handling
	
	velocity.y = actVector.y*delta*speed*(1+int(velocity.y > 0)*0.40)
	velocity.x = actVector.x*delta*steer
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Lose" in kinCollisionInfo.collider.name:
			var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
		elif "Car" in kinCollisionInfo.collider.name:
			carCollision(kinCollisionInfo,delta)
	
	sprBro.rotation = getTargetVector().angle() # Update bro's aiming position
	
	$sprCar.rotation = actVector.x/3 # Handle rotation
	
	get_node("../areaMove/sprActual").position = 150 * actVector
	
	#partTyre.emitting = actVector.y > 0.6 # Handle tyre marks

func getTargetVector():
	if Globals.target == null:
		return Vector2(0,-1) # Looking up
	var relVector = Globals.target.position - position
	return relVector.normalized()

func _on_timerAttack_timeout():
	if Globals.fire == true and Globals.target != null:
		var relVector = getTargetVector()
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = relVector.angle()
		bodyBullet.fireVector = relVector
		bodyBullet.speed = 1600
		bodyBullet.set_collision_mask_bit(3,true)
		get_parent().add_child(bodyBullet)


func btnFire_pressed():
	Globals.fire = true
	get_node("../areaAttack/btnFire").modulate = Color(1,0,0)


func btnFire_released():
	Globals.fire = false
	get_node("../areaAttack/btnFire").modulate = Color(1,1,1)
