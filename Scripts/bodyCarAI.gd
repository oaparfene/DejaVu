extends "res://Scripts/classCar.gd"

var state = "maintain"

var fire = false

var targetted = false
var target = null

var pain: int
var gunName: String
var gunData: Dictionary
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$sndShot.pitch_scale = rng.randf_range(0.7,1.6)

func configure(carData,forMenu = false):
	# General Configure
	for variable in carData:
		set(variable,carData[variable])
	# Gun configure
	gunData["gunName"] = gunName
	for property in gunData:
		if property in Globals.gunUpgrNameArray:
			rng.randomize()
			var upgradeLevel
			if forMenu:
				upgradeLevel = rng.randi_range(0,5)
			else:
				var chaosInt = rng.randi_range(-1,1)
				upgradeLevel = clamp(0, int(Globals.getCurrentLevel()["ID"]/1.5 + chaosInt - 1), 5)
			#print(name," has ",property, " level ",str(upgradeLevel))
			gunData[property] = gunData[property]["levels"][upgradeLevel]
	reload()
	$timerAttack.wait_time = gunData["firerate"]
	$sndShot.stream = load("res://Assets/Sounds/snd_"+str(gunName)+".wav")
	$sndShot.volume_db = -30
	health = maxHealth
	$sprCar.texture = load("res://Assets/Cars/img_"+carName+".png")
	# Set team
	add_to_group(team)
	# Set collision data
	setCollision()

func _physics_process(delta):
	
	AI.getBehaviour(self,state)
	
	var kinCollisionInfo = handleMovement(delta)
	if kinCollisionInfo:
		if kinCollisionInfo.collider == target:
			state = AI.getNewState(self,state)
	
	$sprCar/sprTarget.visible = targetted
	$sprState.texture = load("res://Assets/Icons/img_"+state+".png")
	
	if health/maxHealth < 0.50:
		$partSmoke.emitting = true
		if health/maxHealth < 0.25:
			$partFire.emitting = true

func tryToShoot():
	target = AI.getTargetEntity(self,AI.getEnemies(team))
	var projectiles = Guns.getGunBehaviour(gunData,self,target)
	for bulletData in projectiles:
		get_parent().add_child(bulletData["projectile"])
	$sndShot.play()
	$timerAttack.start()
	gunData["ammo"] -= 1


func _on_timerAttack_timeout():
	if fire == true:
		tryToShoot()


func _on_bodyCarEnemy_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventScreenTouch:
		
		Globals.setTarget(self)

func reload():
	gunData["ammo"] = gunData["maxAmmo"]
