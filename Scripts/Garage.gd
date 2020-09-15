extends Control

func _ready():
	Globals.saveGame()
	updateUI()

func updateUI():
	$btnLeft.disabled = (Globals.getCarIndex() == 0)
	$btnRight.disabled = (Globals.getCarIndex() == Globals.getNoOfCars() - 1)
	$texCar.texture = load("res://Assets/Cars/img_"+str(Globals.getCarName())+".png")
	get_tree().call_group("upgrade","updateUI")

func _on_btnLeft_pressed():
	Globals.prevCar()
	updateUI()

func _on_btnRight_pressed():
	Globals.nextCar()
	updateUI()

func _on_btnBack_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")

func _on_btnReset_pressed():
	Globals.resetCarUpgrades()
	get_tree().call_group("upgrade","updateUI")

func _on_btnPlay_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")


