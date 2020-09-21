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
	$texCar.self_modulate = Color(0.1,0.1,0.1)+Color(0.9,0.9,0.9)*int(Globals.getUnlocked())
	$texCar/btnUnlock.visible = not Globals.getUnlocked()
	$texCar/btnUnlock.text = str(Globals.getUnlockCostCar()) + "$"
	get_tree().call_group("upgrade","updateUI")
	get_tree().call_group("moneyUI","updateUI")
	get_tree().call_group("wpnSlotsUI","updateUI")

func _on_btnLeft_pressed():
	Globals.prevCar()
	updateUI()

func _on_btnRight_pressed():
	Globals.nextCar()
	updateUI()

func _on_btnUnlock_pressed():
	Globals.unlockCar()
