extends Control

func _ready():
	Globals.saveGame()
	updateUI()

func updateUI():
	$btnLeft.disabled = (Globals.getCarIndex() == 0)
	$btnLeft.visible = not (Globals.getCarIndex() == 0)
	$btnRight.disabled = (Globals.getCarIndex() == Globals.getNoOfCars() - 1)
	$btnRight.visible = not (Globals.getCarIndex() == Globals.getNoOfCars() - 1)
	$texCar.texture = load("res://Assets/Cars/img_"+str(Globals.getCarName())+".png")
	$texCar.modulate = Color(0.1,0.1,0.1)+Color(0.9,0.9,0.9)*int(Globals.getUnlocked())
	$btnUnlock.visible = not Globals.getUnlocked()
	$btnUnlock.text = str(Globals.getUnlockCost()) + "$"
	get_tree().call_group("upgrade","updateUI")
	get_tree().call_group("moneyUI","updateUI")
	get_tree().call_group("wpnSlotsUI","updateUI")

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
	updateUI()

func _on_btnPlay_pressed():
	if Globals.getUnlocked():
		var _currentScene = get_tree().change_scene("res://Scenes/Runway.tscn")

func _on_btnUnlock_pressed():
	Globals.unlockCar()
