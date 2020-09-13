extends Control



func _ready():
	pass # Replace with function body.


func _on_btnCars_pressed():
	get_tree().change_scene("res://Garage.tscn")


func _on_btnGuns_pressed():
	get_tree().change_scene("res://GunShop.tscn")


func _on_btnEnergy_pressed():
	get_tree().change_scene("res://EnergyShop.tscn")
