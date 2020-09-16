extends PopupPanel

var load_objGridItem = preload("res://Scenes/objGridItem.tscn")

func _ready():
	pass


func _on_wpnPopup_about_to_show():
	for gunName in Globals.gunNameArray:
		if Globals.getUnlocked(gunName):
			print(gunName)
			var objGridItem = load_objGridItem.instance()
			objGridItem.currentWeaponName = gunName
			objGridItem.get_node("sprWeapon").texture = load("res://Assets/Guns/img_" + gunName + ".png")
			objGridItem.connect("weapon_selected", get_parent(), "setWeaponSlot")
			$vBox/gridCtn.add_child(objGridItem)
