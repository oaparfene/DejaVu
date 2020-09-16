extends Button

export var slot:int
var wpnPopup

var load_wpnPopup = preload("res://Scenes/wpnPopup.tscn")

func _ready():
	if slot == 0:
		disabled = true
	$labDescription.text = "Weapons Slot " + str(slot)

func _on_weaponSlot_pressed():
	wpnPopup = load_wpnPopup.instance()
	add_child(wpnPopup)
	wpnPopup.popup_centered()

func setWeaponSlot(wpnName):
	Globals.setWeaponSlot(slot, wpnName)
	updateUI()
	wpnPopup.queue_free()

func updateUI():
	if slot < Globals.getMaxSlots():
		var gunName = Globals.getGunName(slot)
		$sprWeapon.texture = load("res://Assets/Guns/img_" + gunName + ".png")
		$labDescription.text = gunName
		visible = true
	else:
		visible = false
