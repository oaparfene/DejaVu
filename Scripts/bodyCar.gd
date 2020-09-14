extends "res://Scripts/classCar.gd"

var velocity = Vector2.ZERO
var haveFuel = true

func _ready():
	timerAttack.wait_time = 0.3
	var carData = Globals.getCarVariables()
	carName = carData["name"]
	maxHealth = carData["health"]
	health = maxHealth
	speed = carData["speed"]
	steer = carData["steer"]
	fuel = carData["fuel"]
	maxFuel = carData["maxFuel"]
	armor = carData["armor"]
	Globals.resetInputs()
	$sprCar.texture = load("res://Assets/Cars/img_"+str(carData["name"])+".png")

func _physics_process(delta):
	
	Globals.set_posCarPlayer(position)
	
	haveFuel = fuel > 0
	
	partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	if haveFuel:
		velocity.y = Globals.carVector.y*delta*speed*(1+int(velocity.y > 0)*0.40)
		velocity.x = Globals.carVector.x*delta*steer
	else:
		velocity = Vector2(0,Globals.roadSpeed*delta)
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Lose" in kinCollisionInfo.collider.name:
			var _currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")
	
	sprBro.rotation = Globals.fireVector.angle() # Update bro's aiming position
	
	if haveFuel:
		rotation = Globals.carVector.x/3 # Handle rotation
		#partTyre.emitting = Globals.carVector.y > 0.6 # Handle tyre marks
		changeFuel(-4*delta) # Deplete fuel

func changeFuel(amount):
	fuel += amount
	get_tree().call_group("fuelUI","updateFuelUI",fuel,maxFuel)

func _on_timerAttack_timeout():
	if Globals.fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = Globals.fireVector.angle()
		bodyBullet.fireVector = Globals.fireVector
		bodyBullet.speed = 1600
		bodyBullet.set_collision_mask_bit(3,true)
		get_parent().add_child(bodyBullet)
