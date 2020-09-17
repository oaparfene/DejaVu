extends Control

#func _ready():
#	for slot in range(Globals.getMaxSlots()):
#		get_node("areaAttack/contFire/objFire"+str(slot)).visible = true

func setPlayerCarVector(vector):
	get_tree().call_group("player","areaMove_changed",vector)

func _on_objFire_button_down(extra_arg_0): # extra_arg_0 = slot
	get_tree().call_group("player","fireGun",Globals.getGunInSlotName(extra_arg_0))
	get_node("areaAttack/contFire/objFire"+str(extra_arg_0)).modulate = Color(1,0,0)

func _on_objFire_button_up(extra_arg_0):
	get_tree().call_group("player","ceaseGun",Globals.getGunInSlotName(extra_arg_0))
	get_node("areaAttack/contFire/objFire"+str(extra_arg_0)).modulate = Color(1,1,1)
