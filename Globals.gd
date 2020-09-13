extends Node

var roadSpeed = 500
var carVector = Vector2.ZERO
var fireVector = Vector2.ZERO
var fire = false

var cars = {
	"vox":{
		"health":500,
		"engine":[300,350,400,450,500,550],
		"steering":[100,125,150,175,200,225],
		"gas":[100,120,140,160,180,200],
		"armor":[0,5,10,15,20,25]
	},
	"hex":{
		"health":1000,
		"engine":[500,550,600,650,700,750],
		"steering":[200,225,250,275,300,325],
		"gas":[200,220,240,260,280,300],
		"armor":[5,10,15,20,25,30]
	}
}

var upgrades = {
	"vox":{
		"engine":0,
		"steering":0,
		"gas":0,
		"armor":0
	},
	"hex":{
		"engine":0,
		"steering":0,
		"gas":0,
		"armor":0
	}
}

# UPGRADABLES
var carSpeed = 300
var carSteer = 100
var carFuel = {"current":100,"max":100}
var carArmor = 0

func changeFuel(amount):
	carFuel["current"] += amount
	get_tree().call_group("fuelUI","updateFuelUI")

func resetFuel():
	carFuel["current"] = carFuel["max"]
