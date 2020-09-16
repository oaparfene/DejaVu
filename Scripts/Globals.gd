extends Node

var roadSpeed = 500
var carVector = Vector2.ZERO
var fire = false
var target = null

var activeCarIndex:int = 0
var carNameArray = []
var gunNameArray = []
var money = 0
var levelMoney = 0

# DEV MODE

var autoTarget = true
var autoFire = false
var freeUpgrades = true

var cars = {
	"squid":{
		"health":500,
		"unlockCost":0,
		"engine":	{"levels":[300, 350, 400, 450, 500, 550], 		"baseCost":100, 	"mod":1.15},
		"steering":	{"levels":[100, 125, 150, 175, 200, 225], 		"baseCost":80, 		"mod":1.20},
		"handling":	{"levels":[2, 2.2, 2.4, 2.6, 2.8, 3], 			"baseCost":140, 	"mod":1.10},
		"armor":	{"levels":[0, 5, 10, 15, 20, 25], 				"baseCost":160, 	"mod":1.05},
		"slots":2,
		"mass":30},
	"vice":{
		"health":800,
		"unlockCost":1500,
		"engine":	{"levels":[500, 550, 600, 650, 700, 750], 		"baseCost":200, 	"mod":1.15},
		"steering":	{"levels":[200, 225, 250, 275, 300, 325], 		"baseCost":180, 	"mod":1.20},
		"handling":	{"levels":[3, 3.2, 3.4, 3.6, 3.8, 4], 			"baseCost":225, 	"mod":1.10},
		"armor":	{"levels":[5, 10, 15, 20, 25, 30], 				"baseCost":250, 	"mod":1.10},
		"slots":2,
		"mass":50},
	"manta":{
		"health":1000,
		"unlockCost":4000,
		"engine":	{"levels":[800, 850, 900, 950, 1000, 1050], 	"baseCost":400, 	"mod":1.15},
		"steering":	{"levels":[400, 425, 550, 575, 600, 625], 		"baseCost":350, 	"mod":1.20},
		"handling":	{"levels":[4, 4.2, 4.4, 4.6, 4.8, 5], 			"baseCost":425, 	"mod":1.10},
		"armor":	{"levels":[0, 4, 8, 12, 16, 20], 				"baseCost":450, 	"mod":1.10},
		"slots":2,
		"mass":80},
	"goliath":{
		"health":2000,
		"unlockCost":10000,
		"engine":	{"levels":[500, 550, 600, 650, 700, 750], 		"baseCost":600, 	"mod":1.15},
		"steering":	{"levels":[200, 225, 250, 275, 300, 325], 		"baseCost":550, 	"mod":1.20},
		"handling":	{"levels":[1, 1.2, 1.4, 1.6, 1.8, 2], 			"baseCost":625, 	"mod":1.10},
		"armor":	{"levels":[25, 30, 35, 40, 45, 50], 			"baseCost":650, 	"mod":1.10},
		"slots":3,
		"mass":300}
}

var enemies = {
	"toad":{
		"health":150,
		"money":50,
		"fireRate":1,
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
		"fireRate":0.3,
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
		"fireRate":0.1,
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
		"fireRate":0.2,
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
		"speed":1600,
		"fireRate":	{"levels":[1, 0.9, 0.8, 0.7, 0.6, 0.5], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05, 1.10, 1.15, 1.20, 1.25, 1.30], "baseCost":100, "mod":1.15} # kill bonus
	},
	"shotgun":{
		"speed":1600,
		"fireRate":	{"levels":[2, 1.8, 1.6, 1.4, 1.2, 1], 			"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[1, 0.9, 0.8, 0.7, 0.6, 0.5],			"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[100, 120, 140, 160, 180, 200], 		"baseCost":100, "mod":1.15},
		"misc":		{"levels":[5, 6, 7, 8, 9, 10], 					"baseCost":100, "mod":1.15} # projectiles
	},
	"smg":{
		"speed":1600,
		"fireRate":	{"levels":[0.5, 0.4, 0.3, 0.2, 0.15, 0.1], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05,1.10,1.15,1.20,1.25,1.30], 		"baseCost":100, "mod":1.15}
	},
	"sniper":{
		"speed":1600,
		"fireRate":	{"levels":[2, 1.7, 1.4, 1.1, 0.8, 0.5], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05,1.10,1.15,1.20,1.25,1.30], 		"baseCost":100, "mod":1.15}
	},
	"rpg":{
		"speed":800,
		"fireRate":	{"levels":[2, 1.7, 1.4, 1.1, 0.8, 0.5], 		"baseCost":50, 	"mod":1.15},
		"spread":	{"levels":[0.3, 0.25, 0.20, 0.15, 0.1, 0.05],	"baseCost":50, 	"mod":1.15},
		"damage":	{"levels":[15, 20, 25, 30, 35, 40], 			"baseCost":100, "mod":1.15},
		"misc":		{"levels":[1.05,1.10,1.15,1.20,1.25,1.30], 		"baseCost":100, "mod":1.15}
	}
}

var upgs = {}

func _ready():
	resetSaveData()
	saveGame()

func transferFunds():
	money += levelMoney
	levelMoney = 0

func nextCar():
	activeCarIndex += 1

func prevCar():
	activeCarIndex -= 1

func getCarIndex():
	return activeCarIndex

func getCarName():
	return carNameArray[activeCarIndex]

func getNoOfCars():
	return carNameArray.size()

func getUnlocked(query = getCarName()):
	return upgs[query]["unlocked"]

func getUnlockCost():
	var cost = cars[getCarName()]["unlockCost"]
	return cost

func unlockCar():
	var cost = getUnlockCost()
	if money < cost and not freeUpgrades:
		return
	upgs[getCarName()]["unlocked"] = true
	if not freeUpgrades:
		money -= cost
	get_tree().call_group("unlockUI","updateUI")

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
	carData["fireRate"] = enemies[carName]["fireRate"]
	carData["speed"] = enemies[carName]["engine"]
	carData["steer"] = enemies[carName]["steering"]
	carData["armor"] = enemies[carName]["armor"]
	carData["handling"] = enemies[carName]["handling"]
	carData["mass"] = enemies[carName]["mass"]
	carData["stupid"] = enemies[carName]["stupid"]
	return carData.duplicate(true)

func upgrade(upgName):
	var cost = getUpgradeCost(upgName)
	if money < cost and not freeUpgrades:
		return
	if upgs[getCarName()][upgName] < 5:
		upgs[getCarName()][upgName] += 1
		if not freeUpgrades:
			money -= cost
		get_tree().call_group("moneyUI","updateUI")

func getUpgradeLevel(upgName):
	return upgs[getCarName()][upgName]

func getUpgradeCost(upgName):
	var carName = getCarName()
	var baseCost = cars[carName][upgName]["baseCost"]
	var mod = cars[carName][upgName]["mod"]
	var level = getUpgradeLevel(upgName)
	if level < 5:
		return ceil(baseCost * pow(mod,level))
	else:
		return ceil(baseCost * pow(mod,4))

func resetInputs():
	carVector = Vector2.ZERO
	fire = false

func resetCarUpgrades():
	upgs[carNameArray[activeCarIndex]] = {"unlocked":false,"engine":0,"steering":0,"handling":0,"armor":0}
	money = 0

func setTarget(car):
	if target != null:
		target.targetted = false
	target = car
	target.targetted = true

func _physics_process(_delta):
	if autoTarget == true and target == null:
		var targets = get_tree().get_nodes_in_group("enemy")
		if not targets.empty():
			setTarget(targets[0])
	if autoFire:
		fire = true

func setWeaponSlotGlobal(slotNo, wpnName):
	upgs[activeCarIndex]["slots"][slotNo] = wpnName

# SAVE / LOAD

var saveVariables = ["upgs","activeCarIndex","money"]

func resetSaveData():
	carNameArray = []
	for carName in cars:
		carNameArray.append(carName)
		upgs[carName] = {"unlocked":false,"engine":0,"steering":0,"handling":0,"armor":0,"slots":[]}
	gunNameArray = []
	for gunName in guns:
		gunNameArray.append(gunName)
		upgs[gunName] = {"unlocked":false,"fireRate":0,"spread":0,"damage":0,"misc":0}
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


