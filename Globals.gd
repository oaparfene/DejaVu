extends Node

var parSpeed = 500

var carSpeed = 2
var carVector = Vector2.ZERO
var carFuel = {"current":100,"max":100}
var fireVector = Vector2.ZERO
var fire = false

func changeFuel(amount):
	carFuel["current"] += amount
	get_tree().call_group("fuelUI","updateFuelUI")

func resetFuel():
	carFuel["current"] = carFuel["max"]
