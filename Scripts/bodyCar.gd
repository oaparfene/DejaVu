extends "res://Scripts/classCar.gd"

onready var Runway = get_tree().get_root().get_node("Runway")

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var sprBro = $sprBro

var haveFuel = true

func _ready():
	var carData = Globals.getCarVariables()
	slots = Globals.getGunVariables()
	for variable in carData:
		set(variable,carData[variable])
	for gunName in slots:
		gunNames.append(gunName)
		slots[gunName]["fire"] = false # Set fire to false
		var timer = Timer.new() # Create firerate timer
		timer.one_shot = true
		timer.wait_time = slots[gunName]["firerate"]
		timer.connect("timeout",self,"tryToShoot",[gunName])
		add_child(timer)
		slots[gunName]["timer"] = timer # Store the timer reference
	health = maxHealth
	mass *= 1 + float(armor)/100
	Globals.resetInputs()
	team = "player"

func _physics_process(delta):
	
	handleMovement(delta)
	
	Runway.get_node("areaMove/sprActual").position = 150 * actVector
	
	get_tree().call_group("gunsUI","updateUI",slots)

#func _on_timerAttack_timeout():
#	if Globals.fire == true and Globals.target != null:
#		var relVector = getTargetVector()
#		var bodyBullet = bodyBullet_load.instance()
#		bodyBullet.position = position
#		bodyBullet.rotation = relVector.angle()
#		bodyBullet.fireVector = relVector
#		bodyBullet.speed = 1600
#		bodyBullet.set_collision_mask_bit(3,true)
#		get_parent().add_child(bodyBullet)

func areaMove_changed(vector):
	carVector = vector

func fireGun(gunName):
	slots[gunName]["fire"] = true
	tryToShoot(gunName)

func ceaseGun(gunName):
	slots[gunName]["fire"] = false

var inputKeys = [KEY_1,KEY_2,KEY_3,KEY_4]

func _input(event):
	
	if event is InputEventKey:
		
		for keyIndex in range(inputKeys.size()):
			
			if event.scancode == inputKeys[keyIndex] and keyIndex < gunNames.size():
			
				if event.pressed:
					fireGun(gunNames[keyIndex])
				else:
					ceaseGun(gunNames[keyIndex])







