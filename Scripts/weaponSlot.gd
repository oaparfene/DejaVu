extends Button

export var slot:int
var wpnPopup

var load_wpnPopup = preload("res://Scenes/wpnPopup.tscn")

func _ready():
	if slot == 0:
		disabled = true
	$labDescription.text = "Weapons Slot " + str(slot)

func _on_weaponSlot_pressed():
	if not Globals.getUnlocked():
		return
	wpnPopup = load_wpnPopup.instance()
	add_child(wpnPopup)
	wpnPopup.popup_centered()

func setWeaponSlot(wpnName):
	Globals.setWeaponSlot(slot, wpnName)
	updateUI()
	wpnPopup.queue_free()

func updateUI():
	if slot < Globals.getMaxSlots():
		var skinName
		var gunName = Globals.getGunInSlotName(slot)
		if gunName != "empty":
			skinName = Globals.upgs[gunName]["equippedSkin"]
		else:
			skinName = gunName
		$sprWeapon.texture = load("res://Assets/Guns/img_" + skinName + ".png")
		$labDescription.text = gunName
		visible = true
	else:
		visible = false
