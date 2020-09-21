extends Control

var currentScene


func _on_labPlay_pressed():
	if Globals.getUnlocked():
		currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")

func _on_labGarage_pressed():
	currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")

func _on_labSettings_pressed():
	currentScene = get_tree().change_scene("res://Scenes/Settings.tscn")

func _on_labReset_pressed():
	Globals.resetSaveData()
