extends "res://Scripts/classCar.gd"

var state = "maintain"

var carVector = Vector2.ZERO
var fireVector = Vector2.ZERO
var fire = false

var targetted = false

var ammo = 0

func configure(carData):
	$timerAttack.wait_time = carData["fireRate"]
	$timerState.wait_time = carData["stupid"]
	for variable in carData:
		set(variable,carData[variable])
	health = maxHealth
	$sprCar.texture = load("res://Assets/Cars/img_"+carName+".png")
	team = "enemy"

func _physics_process(delta):
	
	$partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	AI.getBehaviour(state,self)
	
	actVector += (carVector - actVector)*delta*handling
	
	velocity = actVector*speed*delta
	
	var kinCollisionInfo = move_and_collide(velocity)
	if kinCollisionInfo: # If we collided
		if "Car" in kinCollisionInfo.collider.name:
			carCollision(kinCollisionInfo,delta)
	
	$sprBro.rotation = fireVector.angle() # Update bro's aiming position
	
	$sprCar.rotation = actVector.x/3 # Handle rotation
	
	if ammo == 0 and state == "shoot":
		_on_timerState_timeout()
	
	$sprCar/sprTarget.visible = targetted
	

func _on_timerState_timeout():
	state = AI.getNewState(state)
	if state == "shoot":
		ammo = 5
	#print(name," is now is state: ",state)


func _on_timerAttack_timeout():
	if fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = fireVector.angle()
		bodyBullet.fireVector = fireVector
		bodyBullet.speed = 1600
		bodyBullet.set_collision_mask_bit(1,true)
		get_parent().add_child(bodyBullet)
		ammo -= 1


func _on_bodyCarEnemy_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventScreenTouch:
		
		Globals.setTarget(self)
