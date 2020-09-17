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
	modulate = Color(1,1,1) * (1-slots[gunName]["timer"].time_left/slots[gunName]["timer"].wait_time)
