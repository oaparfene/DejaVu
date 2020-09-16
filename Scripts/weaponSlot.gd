extends Button

var popup

var load_objGridItem = preload("res://Scenes/objGridItem.tscn")

func _ready():
	$labDescription.text = "Weapons Slot 1"



func _on_weaponSlot_pressed():
	popup = PopupPanel.new()
	popup.connect("popup_hide", self, "deletePopups")
	var gridCtn = GridContainer.new()
	popup.add_child(gridCtn)
	for gunIndex in Globals.gunNameArray:
		if Globals.upgs[gunIndex]["unlocked"] == true:
			var objGridItem = load_objGridItem.instance()
			objGridItem.currentWeaponName = gunIndex
			objGridItem.get_node("sprWeapon").texture = load("res://Assets/Guns/img_" + gunIndex + ".png")
			objGridItem.connect("weapon_selected", self, "setWeaponSlot")
			gridCtn.add_child(objGridItem)
	add_child(popup)
	popup.popup_centered()

func deletePopups():
	popup.queue_free()

func setWeaponSLot(name):
	pass
