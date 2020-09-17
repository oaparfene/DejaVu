extends Button

var currentWeaponName
var gunName

export(int) var slot

func _ready():
	updateUI()

func updateUI():
	gunName = Globals.getGunInSlotName(slot)
	if gunName != "":
		$sprWeapon.texture = load("res://Assets/Guns/img_"+gunName+".png")
	else:
		visible = false
