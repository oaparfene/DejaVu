extends Control

func _ready():
	Globals.saveGame()
	updateUI()

func updateUI():
	pass


func _on_btnRight_pressed():
	Globals.nextGun()
	updateUI()


func _on_btnLeft_pressed():
	Globals.prevGun()
	updateUI()


func _on_btnBack_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")


func _on_btnReset_pressed():
	Globals.resetGunUpgrades()
	updateUI()


func _on_btnPlay_pressed():
	pass # Replace with function body.
