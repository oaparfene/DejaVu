extends Tabs

onready var upgradeNode_load = preload("res://Scenes/upgradeNode.tscn")
onready var vBoxContainer = get_node("VBoxContainer")

export(int) var cribLocation

func _ready():
	var upgNames = []
	match cribLocation:
		0:
			upgNames = Globals.carUpgrNameArray
		1:
			upgNames = Globals.gunUpgrNameArray
	for upgName in upgNames:
		var upgradeNode = upgradeNode_load.instance()
		upgradeNode.configure(cribLocation,upgName)
		vBoxContainer.add_child(upgradeNode)
