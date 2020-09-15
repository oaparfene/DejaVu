extends HBoxContainer

var currentScene

func _ready():
	updateUI()

func updateUI():
	$btnCoins.text = str(Globals.money) + "$"

func _on_btnCars_pressed():
	currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")


func _on_btnGuns_pressed():
	currentScene = get_tree().change_scene("res://Scenes/GunShop.tscn")


func _on_btnEnergy_pressed():
	currentScene = get_tree().change_scene("res://Scenes/EnergyShop.tscn")


func _on_btnCoins_pressed():
	pass # Replace with function body.
