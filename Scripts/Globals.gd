extends Node

var roadSpeed = 500
var carVector = Vector2.ZERO
var fire = false

var posCarPlayer

var activeCarIndex:int = 0

var carNameArray = []

var target = null

var cars = {
	"vox":{
		"health":500,
		"engine":[300,350,400,450,500,550],
		"steering":[100,125,150,175,200,225],
		"fuel":[100,120,140,160,180,200],
		"armor":[0,5,10,15,20,25],
		"mass":30
	},
	"hex":{
		"health":1000,
		"engine":[500,550,600,650,700,750],
		"steering":[200,225,250,275,300,325],
		"fuel":[200,220,240,260,280,300],
		"armor":[5,10,15,20,25,30],
		"mass":50
	}
}

var enemies = {
	"bad":{
		"health":200,
		"fireRate":1,
		"engine":300,
		"steering":100,
		"armor":5,
		"mass":30,
		"stupid":3
	},
	"bad2":{
		"health":500,
		"fireRate":0.3,
		"engine":400,
		"steering":200,
		"armor":10,
		"mass":50,
		"stupid":2
	},
	"bad3":{
		"health":1000,
		"fireRate":0.1,
		"engine":600,
		"steering":600,
		"armor":15,
		"mass":100,
		"stupid":1
	},
}

var upgs = {}

func _ready():
	for carName in cars:
		carNameArray.append(carName)
		upgs[carName] = {"engine":0,"steering":0,"fuel":0,"armor":0}
	loadGame()
	saveGame()

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

func getCarVariables():
	var carName = carNameArray[activeCarIndex]
	var carData = {}
	carData["carName"] = carName
	carData["maxHealth"] = cars[carName]["health"]
	carData["speed"] = cars[carName]["engine"][upgs[carName]["engine"]]
	carData["steer"] = cars[carName]["steering"][upgs[carName]["steering"]]
	carData["maxFuel"] = cars[carName]["fuel"][upgs[carName]["fuel"]]
	carData["armor"] = cars[carName]["armor"][upgs[carName]["armor"]]
	carData["mass"] = cars[carName]["mass"]
	roadSpeed = carData["speed"]*2
	return carData.duplicate(true)

func getEnemyCarVariables(carName):
	var carData = {}
	carData["carName"] = carName
	carData["maxHealth"] = enemies[carName]["health"]
	carData["fireRate"] = enemies[carName]["fireRate"]
	carData["speed"] = enemies[carName]["engine"]
	carData["steer"] = enemies[carName]["steering"]
	carData["armor"] = enemies[carName]["armor"]
	carData["mass"] = enemies[carName]["mass"]
	carData["stupid"] = enemies[carName]["stupid"]
	return carData.duplicate(true)

func upgrade(upgName):
	if upgs[carNameArray[activeCarIndex]][upgName] < 5:
		upgs[carNameArray[activeCarIndex]][upgName] += 1

func getUpgradeLevel(upgName):
	return upgs[carNameArray[activeCarIndex]][upgName]

func resetInputs():
	carVector = Vector2.ZERO
	fire = false

func resetCarUpgrades():
	upgs[carNameArray[activeCarIndex]] = {"engine":0,"steering":0,"fuel":0,"armor":0}

func set_posCarPlayer(position):
	posCarPlayer = position

# SAVE / LOAD

func createSaveData(): # Copy the state of the game to a save dict
	var saveData = {}
	saveData["upgs"] = upgs
	saveData["activeCarIndex"] = activeCarIndex
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


