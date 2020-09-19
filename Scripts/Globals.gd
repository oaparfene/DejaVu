extends Node

var roadSpeed = 500
var carVector = Vector2.ZERO
var fire = false
var target = null
var camPos = Vector2.ZERO

var activeCarIndex:int = 0
var activeGunIndex:int = 0
var currentCribLocation= "Garage"
var targetPos = 0
var input = false

var carNameArray = []
var carUpgrNameArray = []
var gunNameArray = []
var gunUpgrNameArray = []

var money = 0
var levelMoney = 0

# DEV MODE

var autoTarget = false
var autoFire = false
var freeUpgrades = false
var invincible = false
var rapidFire = false

var cars = {
	"squid":{
		"health":500,
		"unlockCost":0,
		"engine":	{"levels":[300, 350, 400, 450, 500, 550], 		"baseCost":100, 	"mod":1.15},
		"steering":	{"levels":[100, 125, 150, 175, 200, 225], 		"baseCost":80, 		"mod":1.20},
		"handling":	{"levels":[2, 2.2, 2.4, 2.6, 2.8, 3], 			"baseCost":140, 	"mod":1.10},
		"armor":	{"levels":[0, 5, 10, 15, 20, 25], 				"baseCost":160, 	"mod":1.05},
		"slots":4,
		"mass":30},
	"vice":{
		"health":800,
		"unlockCost":1500,
		"engine":	{"levels":[500, 550, 600, 650, 700, 750], 		"baseCost":200, 	"mod":1.15},
		"steering":	{"levels":[200, 225, 250, 275, 300, 325], 		"baseCost":180, 	"mod":1.20},
		"handling":	{"levels":[3, 3.2, 3.4, 3.6, 3.8, 4], 			"baseCost":225, 	"mod":1.10},
		"armor":	{"levels":[5, 10, 15, 20, 25, 30], 				"baseCost":250, 	"mod":1.10},
		"slots":4,
		"mass":40},
	"manta":{
		"health":1000,
		"unlockCost":4000,
		"engine":	{"levels":[800, 850, 900, 950, 1000, 1050], 	"baseCost":400, 	"mod":1.15},
		"steering":	{"levels":[400, 425, 550, 575, 600, 625], 		"baseCost":350, 	"mod":1.20},
		"handling":	{"levels":[4, 4.2, 4.4, 4.6, 4.8, 5], 			"baseCost":425, 	"mod":1.10},
		"armor":	{"levels":[0, 4, 8, 12, 16, 20], 				"baseCost":450, 	"mod":1.10},
		"slots":4,
		"mass":60},
	"goliath":{
		"health":2000,
		"unlockCost":10000,
		"engine":	{"levels":[500, 550, 600, 650, 700, 750], 		"baseCost":600, 	"mod":1.15},
		"steering":	{"levels":[200, 225, 250, 275, 300, 325], 		"baseCost":550, 	"mod":1.20},
		"handling":	{"levels":[1, 1.2, 1.4, 1.6, 1.8, 2], 			"baseCost":625, 	"mod":1.10},
		"armor":	{"levels":[25, 30, 35, 40, 45, 50], 			"baseCost":650, 	"mod":1.10},
		"slots":4,
		"mass":100}
}

var enemies = {
	"toad":{
		"health":150,
		"money":50,
		"firerate":1,
		"engine":300,
		"steering":100,
		"armor":5,
		"handling":2,
		"mass":20,
		"stupid":3
	},
	"virtue":{
		"health":350,
		"money":125,
		"firerate":0.3,
		"engine":400,
		"steering":300,
		"armor":10,
		"handling":3,
		"mass":40,
		"stupid":2
	},
	"viper":{
		"health":800,
		"money":300,
		"firerate":0.1,
		"engine":600,
		"steering":600,
		"armor":15,
		"handling":5,
		"mass":80,
		"stupid":1
	},
	"baron":{
		"health":2000,
		"money":500,
		"firerate":0.2,
		"engine":300,
		"steering":100,
		"armor":25,
		"handling":2,
		"mass":300,
		"stupid":5
	},
}

var guns = {
	"pistol":{
		"unlockCost":0,
		"speed":1600,
		"firerate":	{"levels":[1, 0.9, 0.8, 0.7, 0.6, 0.5], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05, 1.10, 1.15, 1.20, 1.25, 1.30], "baseCost":100, "mod":1.15} # kill bonus
	},
	"shotgun":{
		"unlockCost":500,
		"speed":1600,
		"firerate":	{"levels":[2, 1.8, 1.6, 1.4, 1.2, 1], 			"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[1, 0.9, 0.8, 0.7, 0.6, 0.5],			"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[100, 120, 140, 160, 180, 200], 		"baseCost":100, "mod":1.15},
		"misc":		{"levels":[5, 6, 7, 8, 9, 10], 					"baseCost":100, "mod":1.15} # projectiles
	},
	"smg":{
		"unlockCost":1500,
		"speed":1600,
		"firerate":	{"levels":[0.3, 0.25, 0.2, 0.15, 0.10, 0.05], 	"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.6, 0.5, 0.4, 0.3, 0.2, 0.1],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[5, 8, 11, 14, 17, 20], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05,1.10,1.15,1.20,1.25,1.30], 		"baseCost":100, "mod":1.15} # ricochet
	},
	"sniper":{
		"unlockCost":2500,
		"speed":1600,
		"firerate":	{"levels":[2, 1.7, 1.4, 1.1, 0.8, 0.5], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05,1.10,1.15,1.20,1.25,1.30], 		"baseCost":100, "mod":1.15} # armor negation
	},
	"rpg":{
		"unlockCost":5000,
		"speed":1200,
		"firerate":	{"levels":[4, 3.5, 3, 2.5, 2, 1.5], 			"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.5, 0.4, 0.3, 0.2, 0.1, 0.05],		"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[500, 600, 700, 800, 900, 1000], 		"baseCost":100, "mod":1.15},
		"misc":		{"levels":[300,350,400,450,500,550], 			"baseCost":100, "mod":1.15} # radius
	}
}

var upgs = {}

func _ready():
	OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ") # this is the rick roll line, disable it after you got pranked bro
	initialiseData()
	loadGame()



# INITIALISE

func resetInputs():
	carVector = Vector2.ZERO
	fire = false

func initialiseData():
	carNameArray = []
	for carName in cars:
		initialiseCarUpgrades(carName)
	gunNameArray = []
	for gunName in guns:
		initialiseGunUpgrades(gunName)
	money = 0

func getCarVariables():
	var carName = getCarName()
	var carData = {}
	carData["carName"] = 	carName
	carData["maxHealth"] = 	cars[carName]["health"]
	carData["speed"] = 		cars[carName]["engine"]["levels"][upgs[carName]["engine"]]
	carData["steer"] = 		cars[carName]["steering"]["levels"][upgs[carName]["steering"]]
	carData["handling"] = 	cars[carName]["handling"]["levels"][upgs[carName]["handling"]]
	carData["armor"] = 		cars[carName]["armor"]["levels"][upgs[carName]["armor"]]
	carData["mass"] = 		cars[carName]["mass"]
	roadSpeed = carData["speed"]*2
	return carData.duplicate(true)

func getEnemyCarVariables(carName):
	var carData = {}
	carData["carName"] = carName
	carData["maxHealth"] = enemies[carName]["health"]
	carData["money"] = enemies[carName]["money"]
	carData["firerate"] = enemies[carName]["firerate"]
	carData["speed"] = enemies[carName]["engine"]
	carData["steer"] = enemies[carName]["steering"]
	carData["armor"] = enemies[carName]["armor"]
	carData["handling"] = enemies[carName]["handling"]
	carData["mass"] = enemies[carName]["mass"]
	carData["stupid"] = enemies[carName]["stupid"]
	return carData.duplicate(true)

func getGunVariables():
	var carName = getCarName()
	var slots = upgs[carName]["slots"]
	var gunData = {}
	for gunName in slots.values():
		if gunName == "empty":
			continue
		gunData[gunName] = {}
		gunData[gunName]["gunName"] = gunName
		gunData[gunName]["speed"] = guns[gunName]["speed"]
		gunData[gunName]["firerate"] = guns[gunName]["firerate"]["levels"][upgs[gunName]["firerate"]]
		gunData[gunName]["spread"] = guns[gunName]["spread"]["levels"][upgs[gunName]["spread"]]
		gunData[gunName]["damage"] = guns[gunName]["damage"]["levels"][upgs[gunName]["damage"]]
		gunData[gunName]["misc"] = guns[gunName]["misc"]["levels"][upgs[gunName]["misc"]]
	return gunData.duplicate(true)

func initialiseCarUpgrades(carName):
	carNameArray.append(carName)
	upgs[carName] = {"unlocked":false,"engine":0,"steering":0,"handling":0,"armor":0,"slots":{"0":"pistol"}}
	carUpgrNameArray = ["engine","steering","handling","armor"]
	for slot in range(1,cars[carName]["slots"]):
		upgs[carName]["slots"][str(slot)] = "empty"

func initialiseGunUpgrades(gunName):
	gunNameArray.append(gunName)
	upgs[gunName] = {"unlocked":false,"firerate":0,"spread":0,"damage":0,"misc":0}
	gunUpgrNameArray = ["firerate","spread","damage","misc"]

func getGunInSlotName(slot):
	if slot < getMaxSlots():
		return upgs[getCarName()]["slots"][str(slot)]
	else:
		return "empty"

func setWeaponSlot(slotNo, wpnName):
	upgs[carNameArray[activeCarIndex]]["slots"][str(slotNo)] = wpnName
	saveGame()

func transferFunds():
	money += levelMoney
	levelMoney = 0

func addMoney(mny):
	money += mny
	saveGame()

func nextCar():
	activeCarIndex += 1
	saveGame()

func nextGun():
	activeGunIndex += 1
	saveGame()

func prevCar():
	activeCarIndex -= 1
	saveGame()

func prevGun():
	activeGunIndex -= 1
	saveGame()

func nextTarget(change = true):
	var targets = get_tree().get_nodes_in_group("enemy")
	if targets.empty(): # If there are no targets
		return
	if change == false: # If we're not changing
		if target == null: # If there's no target
			target = targets[0] # Grab the first target
			target.targetted = true
			targetPos = 0
	else: # If we are changing
		target.targetted = false
		targetPos = (targetPos+1)%targets.size()
		target = targets[targetPos]
		target.targetted = true

func setTarget(car):
	if target != null:
		target.targetted = false
	target = car
	target.targetted = true

func getCarIndex():
	return activeCarIndex

func getGunIndex():
	return activeGunIndex

func getCarName():
	return carNameArray[activeCarIndex]

func getGunName():
	return gunNameArray[activeGunIndex]

func getMaxSlots():
	return cars[carNameArray[activeCarIndex]]["slots"]

func getNoOfCars():
	return carNameArray.size()

func getNoOfGuns():
	return gunNameArray.size()



# UNLOCK

func getUnlocked(query = getCarName()):
	return upgs[query]["unlocked"]

func getUnlockCostCar(carName = getCarName()):
	var cost = cars[carName]["unlockCost"]
	return cost

func getUnlockCostGun(gunName = getGunName()):
	var cost = guns[gunName]["unlockCost"]
	return cost

func unlockCar(carName = getCarName()):
	var cost = getUnlockCostCar(carName)
	if money < cost and not freeUpgrades:
		return
	upgs[carName]["unlocked"] = true
	if not freeUpgrades:
		money -= cost
	get_tree().call_group("unlockUI","updateUI")
	saveGame()

func unlockGun(gunName = getGunName()):
	var cost = getUnlockCostGun(gunName)
	if money < cost and not freeUpgrades:
		return
	upgs[gunName]["unlocked"] = true
	if not freeUpgrades:
		money -= cost
	get_tree().call_group("unlockUI","updateUI")
	saveGame()

func unlockAll():
	var prev_freeUpgrades = freeUpgrades
	freeUpgrades = true
	for carName in carNameArray:
		unlockCar(carName)
	for gunName in gunNameArray:
		unlockGun(gunName)
	freeUpgrades = prev_freeUpgrades



# UPGRADES

func upgradeCar(upgName,carName = getCarName()):
	var cost = getUpgradeCost(upgName,carName)
	if money < cost and not freeUpgrades:
		return
	if upgs[carName][upgName] < 5:
		upgs[carName][upgName] += 1
		if not freeUpgrades:
			money -= cost
		get_tree().call_group("moneyUI","updateUI")
		saveGame()

func upgradeGun(upgName,gunName = getGunName()):
	var cost = getGunUpgradeCost(upgName,gunName)
	if money < cost and not freeUpgrades:
		return
	if upgs[gunName][upgName] < 5:
		upgs[gunName][upgName] += 1
		if not freeUpgrades:
			money -= cost
		get_tree().call_group("moneyUI","updateUI")
		saveGame()

func getUpgradeLevel(upgName, query = getCarName()):
	return upgs[query][upgName]

func getUpgradeCost(upgName,carName = getCarName()):
	var baseCost = cars[carName][upgName]["baseCost"]
	var mod = cars[carName][upgName]["mod"]
	var level = getUpgradeLevel(upgName,carName)
	if level < 5:
		return ceil(baseCost * pow(mod,level))
	else:
		return ceil(baseCost * pow(mod,4))

func getGunUpgradeCost(upgName,gunName = getGunName()):
	var baseCost = guns[gunName][upgName]["baseCost"]
	var mod = guns[gunName][upgName]["mod"]
	var level = getUpgradeLevel(upgName, gunName)
	if level < 5:
		return ceil(baseCost * pow(mod,level))
	else:
		return ceil(baseCost * pow(mod,4))

func resetUpgrades():
	if currentCribLocation == "Garage":
		initialiseCarUpgrades(getCarName())
	elif currentCribLocation == "GunShop":
		initialiseGunUpgrades(getGunName())
	saveGame()

func upgradeAll():
	var prev_freeUpgrades = freeUpgrades
	freeUpgrades = true
	for carName in carNameArray:
		for upgName in carUpgrNameArray:
			for upg in cars[carName][upgName]["levels"].size():
				upgradeCar(upgName,carName)
	for gunName in gunNameArray:
		for upgName in gunUpgrNameArray:
			for upg in guns[gunName][upgName]["levels"].size():
				upgradeGun(upgName,gunName)
	freeUpgrades = prev_freeUpgrades




func setCurrentCribLocation(location):
	currentCribLocation = location

func _physics_process(_delta):
	#print()
	if autoTarget == true and target == null:
		nextTarget(false)
	if autoFire:
		fire = true

func toggle(strVar):
	set(strVar,not get(strVar))
	saveGame()

# SAVE / LOAD

var saveVariables = ["upgs","activeCarIndex","money","autoTarget","autoFire","freeUpgrades","invincible"]

func resetSaveData():
	initialiseData()
	saveGame()

func createSaveData(): # Copy the state of the game to a save dict
	var saveData = {}
	for variable in saveVariables:
		saveData[variable] = get(variable)
	return saveData

func loadSaveData(saveData): # Set the state of the game from a save dict
	for variable in saveData:
		set(variable,saveData[variable])

func saveGame(): # Create save file
	var saveFile = File.new()
	var saveData = createSaveData()
	saveFile.open("user://saveFile.json", File.WRITE)
	saveFile.store_line(to_json(saveData))
	saveFile.close()
	
func loadGame(): # Load save file
	var saveFile = File.new()
	if not saveFile.file_exists("user://saveFile.json"):
		return
	saveFile.open("user://saveFile.json", File.READ)
	var saveData = parse_json(saveFile.get_line())
	saveFile.close()
	loadSaveData(saveData)


