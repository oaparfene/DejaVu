extends Control

func _ready():
	for slot in range(Globals.getMaxSlots()):
		get_node("areaAttack/contFire/objFire"+str(slot)).visible = true

func setPlayerCarVector(vector):
	get_tree().call_group("player","areaMove_changed",vector)

func _on_btnFire_pressed():
	get_tree().call_group("player","btnFire_pressed")

func _on_btnFire_released():
	get_tree().call_group("player","btnFire_released")



func _on_objFire_button_down(extra_arg_0):
	get_tree().call_group("player","fireGun",extra_arg_0)

func _on_objFire_button_up(extra_arg_0):
	get_tree().call_group("player","ceaseGun",extra_arg_0)
