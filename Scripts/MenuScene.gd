extends Control

var currentScene

func _ready():
	pass

func _on_labPlay_pressed():
	currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")

func _on_labGarage_pressed():
	currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")
