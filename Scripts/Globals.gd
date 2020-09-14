extends Node

var roadSpeed = 500
var carVector = Vector2.ZERO
var fireVector = Vector2.ZERO
var fire = false

var posCarPlayer

# UPGRADABLES
var carSpeed = 300
var carSteer = 100
var carFuel = {"current":100,"max":100}
var carArmor = 0

var activeCarIndex = 0

var carNameArray = []

var cars = {
	"vox":{
		"health":500,
		"engine":[300,350,400,450,500,550],
		"steering":[100,125,150,175,200,225],
		"fuel":[100,120,140,160,180,200],
		"armor":[0,5,10,15,20,25]
	},
	"hex":{
		"health":1000,
		"engine":[500,550,600,650,700,750],
		"steering":[200,225,250,275,300,325],
		"fuel":[200,220,240,260,280,300],
		"armor":[5,10,15,20,25,30]
	}
}

var upgs = {}

func _ready():
	for carName in cars:
		carNameArray.append(carName)
		upgs[carName] = {"engine":0,"steering":0,"fuel":0,"armor":0}
	loadGame()

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

func setCarVariables():
	carSpeed = cars[carNameArray[activeCarIndex]]["engine"][upgs[carNameArray[activeCarIndex]]["engine"]]
	carSteer = cars[carNameArray[activeCarIndex]]["steering"][upgs[carNameArray[activeCarIndex]]["steering"]]
	carFuel["max"] = cars[carNameArray[activeCarIndex]]["fuel"][upgs[carNameArray[activeCarIndex]]["fuel"]]
	carArmor = cars[carNameArray[activeCarIndex]]["armor"][upgs[carNameArray[activeCarIndex]]["armor"]]
	roadSpeed = carSpeed*2

func upgrade(upgName):
	if upgs[carNameArray[activeCarIndex]][upgName] < 5:
		upgs[carNameArray[activeCarIndex]][upgName] += 1

func getUpgradeLevel(upgName):
	return upgs[carNameArray[activeCarIndex]][upgName]

func changeFuel(amount):
	carFuel["current"] += amount
	get_tree().call_group("fuelUI","updateFuelUI")

func resetFuel():
	carFuel["current"] = carFuel["max"]

func resetInputs():
	carVector = Vector2.ZERO
	fireVector = Vector2.ZERO
	fire = false

func resetCarUpgrades():
	upgs[carNameArray[activeCarIndex]] = {"engine":0,"steering":0,"fuel":0,"armor":0}

func set_posCarPlayer(position):
	posCarPlayer = position

# SAVE / LOAD

func saveGame():
	var saveFile = File.new()
	saveFile.open("user://saveFile.save", File.WRITE)
	saveFile.store_line(to_json(upgs))
	saveFile.close() 
	
func loadGame():
	var saveFile = File.new()
	if not saveFile.file_exists("user://saveFile.save"):
		return
	saveFile.open("user://saveFile.save", File.READ)
	upgs = parse_json(saveFile.get_line())
	saveFile.close()

