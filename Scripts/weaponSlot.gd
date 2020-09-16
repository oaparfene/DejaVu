extends Button

var popup
var slotNo
var equipedWpn

var load_wpnPopup = preload("res://Scenes/wpnPopup.tscn")

func _ready():
	$labDescription.text = "Weapons Slot " + str(slotNo)

func _on_weaponSlot_pressed():
	var wpnPopup = load_wpnPopup.instance()
	add_child(wpnPopup)
	wpnPopup.popup_centered()

func setWeaponSlot(wpnName):
	Globals.setWeaponSlotGlobal(slotNo, wpnName)
	setWeaponSlotLocal(wpnName)

func setWeaponSlotLocal(wpnName):
	equipedWpn = wpnName
	$sprWeapon.texture = load("res://Assets/Guns/img_" + wpnName + ".png")
	$labDescription.text = wpnName

func updateUI():
	if Globals.upgs[Globals.getCarName()]["slots"].has(slotNo):
		setWeaponSlotLocal(Globals.upgs[Globals.getCarName()]["slots"][slotNo])
		visible = true
	else:
		visible = false
