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

func _on_btnResetMoney_pressed():
	Globals.addMoney(-Globals.money)
	updateUI()

func _on_btnAddGrand_pressed():
	Globals.addMoney(1000)
	updateUI()


func _on_btnMinusGrand_pressed():
	Globals.addMoney(-1000)
	updateUI()


func _on_btnBack_pressed():
	var _currentScene = get_tree().change_scene("res://Scenes/MenuScene.tscn")
