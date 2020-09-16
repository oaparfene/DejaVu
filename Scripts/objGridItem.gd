extends Button

signal weapon_selected(name)

var currentWeaponName

func _ready():
	pass 

func _on_objGridItem_pressed():
	emit_signal("weapon_selected", currentWeaponName)
