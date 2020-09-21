extends Control

onready var btnLevel_load = load("res://Scenes/btnLevel.tscn")

func _ready():
	
	# Add level buttons
	for levelData in Globals.roadmap:
		var btnLevel = btnLevel_load.instance()
		btnLevel.configure(levelData)
		$Levels.add_child(btnLevel)


func _on_btnBack_pressed():
	get_tree().change_scene("res://Scenes/Garage.tscn")

func _on_btnPlay_pressed():
	get_tree().change_scene("res://Scenes/Runway.tscn")
