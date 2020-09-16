extends Button

var popup
export var slotNo:int
var equipedWpn
var wpnPopup

var load_wpnPopup = preload("res://Scenes/wpnPopup.tscn")

func _ready():
	if slotNo == 0:
		disabled = true
	$labDescription.text = "Weapons Slot " + str(slotNo)

func _on_weaponSlot_pressed():
	wpnPopup = load_wpnPopup.instance()
	add_child(wpnPopup)
	wpnPopup.popup_centered()

func setWeaponSlot(wpnName):
	Globals.setWeaponSlotGlobal(slotNo, wpnName)
	setWeaponSlotLocal(wpnName)
	if wpnPopup != null:
		wpnPopup.queue_free()

func setWeaponSlotLocal(wpnName):
	equipedWpn = wpnName
	$sprWeapon.texture = load("res://Assets/Guns/img_" + wpnName + ".png")
	$labDescription.text = wpnName

func updateUI():
	if slotNo < Globals.getMaxSlots():
		if Globals.upgs[Globals.getCarName()]["slots"].has(slotNo):
			setWeaponSlotLocal(Globals.upgs[Globals.getCarName()]["slots"][slotNo])
		else:
			setWeaponSlot("empty")
		visible = true
	else:
		visible = false
