extends Button

var popup

var load_wpnPopup = preload("res://Scenes/wpnPopup.tscn")

func _ready():
	$labDescription.text = "Weapons Slot 1"



func _on_weaponSlot_pressed():
	var wpnPopup = load_wpnPopup.instance()
	add_child(wpnPopup)
	wpnPopup.popup_centered()

func setWeaponSlot(name):
	pass
