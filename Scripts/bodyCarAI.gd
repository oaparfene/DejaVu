extends "res://Scripts/classCar.gd"

var state = "maintain"

var fire = false

var targetted = false
var target = null

var maxAmmo: int
var ammo: int
var pain: int
var gunName: String
var gunData: Dictionary
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$sndShot.pitch_scale = rng.randf_range(0.7,1.6)

func configure(carData):
	pain = carData["pain"]
	for variable in carData:
		set(variable,carData[variable])
	gunData["gunName"] = gunName
	for property in gunData:
		if property in Globals.gunUpgrNameArray:
			rng.randomize()
			var chaosInt = rng.randi_range(-1,1)
			var upgradeLevel = clamp(0, int(Globals.getCurrentLevel()["ID"]/1.5 + chaosInt - 1), 5)
			#print(name," has ",property, " level ",str(upgradeLevel))
			gunData[property] = gunData[property]["levels"][upgradeLevel]
	$timerAttack.wait_time = gunData["firerate"]
	$sndShot.stream = load("res://Assets/Sounds/snd_"+str(gunName)+".wav")
	$sndShot.volume_db = -20
	health = maxHealth
	$sprCar.texture = load("res://Assets/Cars/img_"+carName+".png")
	add_to_group(team)
	
	setCollision()

func _physics_process(delta):
	
	AI.getBehaviour(self,state)
	
	var kinCollisionInfo = handleMovement(delta)
	if kinCollisionInfo:
		if kinCollisionInfo.collider == target:
			state = AI.getNewState(self,state)
	
	$sprCar/sprTarget.visible = targetted
	$sprState.texture = load("res://Assets/Icons/img_"+state+".png")

func tryToShoot():
	target = AI.getTargetEntity(self,AI.getEnemies(team))
	var projectiles = Guns.getGunBehaviour(gunData,self,target)
	for bulletData in projectiles:
		get_parent().add_child(bulletData["projectile"])
	$sndShot.play()
	$timerAttack.start()
	ammo -= 1


func _on_timerAttack_timeout():
	if fire == true:
		tryToShoot()


func _on_bodyCarEnemy_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventScreenTouch:
		
		Globals.setTarget(self)