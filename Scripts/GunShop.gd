extends Control

func _ready():
	Globals.saveGame()
	updateUI()

func updateUI():
	$btnLeft.disabled = (Globals.getGunIndex() == 0)
	$btnLeft.visible = not (Globals.getGunIndex() == 0)
	$btnRight.disabled = (Globals.getGunIndex() == Globals.getNoOfGuns() - 1)
	$btnRight.visible = not (Globals.getGunIndex() == Globals.getNoOfGuns() - 1)
	$texGun.texture = load("res://Assets/Guns/img_"+str(Globals.getGunName())+".png")
	$texGun.self_modulate = Color(0.1,0.1,0.1)+Color(0.9,0.9,0.9)*int(Globals.getUnlocked(Globals.getGunName()))
	$texGun/btnUnlock.visible = not Globals.getUnlocked(Globals.getGunName())
	$texGun/btnUnlock.text = str(Globals.getUnlockCostGun()) + "$"
	get_tree().call_group("upgrade","updateUI")
	get_tree().call_group("moneyUI","updateUI")
	get_tree().call_group("wpnSlotsUI","updateUI")

func _on_btnRight_pressed():
	Globals.nextGun()
	updateUI()

func _on_btnLeft_pressed():
	Globals.prevGun()
	updateUI()

func _on_btnUnlock_pressed():
	Globals.unlockGun()
