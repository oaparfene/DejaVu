extends Control

func _ready():
	$contLabels/labLevelMoney.text = "Gained: " + str(Globals.levelMoney) + "$"
	Globals.transferFunds()
	$contLabels/labTotalMoney.text = "Total: " + str(Globals.money) + "$"

func _on_btnReplay_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")

func _on_btnGarage_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")

func _on_btnMenu_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")
