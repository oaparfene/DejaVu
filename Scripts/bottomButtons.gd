extends HBoxContainer

onready var cribInner = get_parent().get_node("ctnViewport/Viewport/CribInner")

func _on_btnBack_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")

func _on_btnReset_pressed():
	Globals.resetUpgrades()
	cribInner.get_node("Garage").updateUI()
	cribInner.get_node("GunShop").updateUI()

func _on_btnPlay_pressed():
	if Globals.getUnlocked():
		var _currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")
