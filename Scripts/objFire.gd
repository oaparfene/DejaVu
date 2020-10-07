extends Button

var gunName

export(int) var slot

func _ready():
	gunName = Globals.getGunInSlotName(slot)
	if gunName != "empty":
		$sprWeapon.texture = load("res://Assets/Guns/img_"+gunName+".png")
	else:
		visible = false

func updateUI(slots):
	if gunName == "empty":
		return
	$sprWeapon.modulate = Color(1,1,1) * (1-slots[gunName]["timer"].time_left/slots[gunName]["timer"].wait_time)
	$labAmmo.text = str(slots[gunName]["ammo"])

func _on_btnFire_mouse_entered():
	get_tree().call_group("player","fireGun",Globals.getGunInSlotName(slot))
	modulate = Color(1,0,0)

func _on_btnFire_mouse_exited():
	get_tree().call_group("player","ceaseGun",Globals.getGunInSlotName(slot))
	modulate = Color(1,1,1)
