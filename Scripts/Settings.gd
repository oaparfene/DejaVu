extends Control

func _ready():
	updateUI()

func updateUI():
	
	$contButtons/labTarget.text = str(Globals.autoTarget)
	$contButtons/labTarget.modulate = Color.green * int(Globals.autoTarget) + Color.red * int(not Globals.autoTarget)
	
	$contButtons/labFire.text = str(Globals.autoFire)
	$contButtons/labFire.modulate = Color.green * int(Globals.autoFire) + Color.red * int(not Globals.autoFire)
	
	$contButtons/labUpgrades.text = str(Globals.freeUpgrades)
	$contButtons/labUpgrades.modulate = Color.green * int(Globals.freeUpgrades) + Color.red * int(not Globals.freeUpgrades)
	
	$contButtons/labInvincible.text = str(Globals.invincible)
	$contButtons/labInvincible.modulate = Color.green * int(Globals.invincible) + Color.red * int(not Globals.invincible)
	
	$contButtons/labRapidFire.text = str(Globals.rapidFire)
	$contButtons/labRapidFire.modulate = Color.green * int(Globals.rapidFire) + Color.red * int(not Globals.rapidFire)
	
	$contButtons/labResetMoney.text = str(Globals.money) + "$"

func _on_btnTarget_pressed():
	Globals.toggle("autoTarget")
	updateUI()

func _on_btnFire_pressed():
	Globals.toggle("autoFire")
	updateUI()

func _on_btnUpgrades_pressed():
	Globals.toggle("freeUpgrades")
	updateUI()

func _on_btnInvincible_pressed():
	Globals.toggle("invincible")
	updateUI()

func _on_btnRapidFire_pressed():
	Globals.toggle("rapidFire")
	updateUI()


func _on_btnResetMoney_pressed():
	Globals.addMoney(-Globals.money)
	updateUI()

func _on_btnAddGrand_pressed():
	Globals.addMoney(1000)
	updateUI()


func _on_btnMinusGrand_pressed():
	Globals.addMoney(-1000)
	updateUI()


func _on_btnUnlockAll_pressed():
	Globals.unlockAll()
	updateUI()

func _on_btnUpgradeAll_pressed():
	Globals.upgradeAll()
	updateUI()

func _on_btnBack_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")
