extends Control

#func _ready():
#	for slot in range(Globals.getMaxSlots()):
#		get_node("areaAttack/contFire/objFire"+str(slot)).visible = true

func setPlayerCarVector(vector):
	get_tree().call_group("player","areaMove_changed",vector)

