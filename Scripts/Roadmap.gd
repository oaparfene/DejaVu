extends Control

onready var btnLevel_load = load("res://Scenes/btnLevel.tscn")

func _ready():
	
	# Add level buttons
	for levelData in Globals.roadmap:
		var btnLevel = btnLevel_load.instance()
		btnLevel.configure(levelData)
		$Levels.add_child(btnLevel)
