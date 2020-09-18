extends "res://Scripts/classCar.gd"

var state = "maintain"

var fire = false

var targetted = false

var ammo = 0

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$sndShot.pitch_scale = rng.randf_range(0.7,1.6)
	print($sndShot.pitch_scale)

func configure(carData):
	$timerAttack.wait_time = carData["firerate"]
	$timerState.wait_time = carData["stupid"]
	for variable in carData:
		set(variable,carData[variable])
	health = maxHealth
	$sprCar.texture = load("res://Assets/Cars/img_"+carName+".png")
	team = "enemy"

func _physics_process(delta):
	
	AI.getBehaviour(self,state)
	
	handleMovement(delta)
	
	if ammo == 0 and state == "shoot":
		_on_timerState_timeout()
	
	$sprCar/sprTarget.visible = targetted
	$sprState.texture = load("res://Assets/Icons/img_"+state+".png")
	

func _on_timerState_timeout():
	state = AI.getNewState(self,state)
	if state == "shoot":
		ammo = 5
	#print(name," is now is state: ",state)


func _on_timerAttack_timeout():
	if fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position
		bodyBullet.rotation = fireVector.angle()
		bodyBullet.fireVector = fireVector
		bodyBullet.speed = 1600.0
		bodyBullet.mass = 30.0/1600.0
		bodyBullet.set_collision_mask_bit(1,true)
		get_parent().add_child(bodyBullet)
		ammo -= 1
		$sndShot.play()


func _on_bodyCarEnemy_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventScreenTouch:
		
		Globals.setTarget(self)
