extends TouchScreenButton

var gunName

export(int) var slot

func _ready():
	gunName = Globals.getGunInSlotName(slot)
	if gunName != "empty":
		get_node("../sprWeapon").texture = load("res://Assets/Guns/img_"+gunName+".png")
	else:
		get_parent().visible = false

func updateUI(slots):
	if gunName == "empty":
		return
	modulate = Color(1,1,1) * (1-slots[gunName]["timer"].time_left/slots[gunName]["timer"].wait_time)
	get_node("../labAmmo").text = str(slots[gunName]["ammo"])

func _on_btnFire_pressed():
	get_tree().call_group("player","fireGun",Globals.getGunInSlotName(slot))
	get_parent().modulate = Color(1,0,0)


func _on_btnFire_released():
	get_tree().call_group("player","ceaseGun",Globals.getGunInSlotName(slot))
	get_parent().modulate = Color(1,1,1)
