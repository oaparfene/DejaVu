extends Control

onready var energyBar = get_node("energyBar")

func _ready():
	energyBar.max_value = Globals.getMaxEnergy()
	energyBar.value = Globals.getEnergy()

func updateUI():
	energyBar.value = Globals.getEnergy()
