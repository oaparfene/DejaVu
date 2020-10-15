extends PopupPanel

var load_objGridItem = preload("res://Scenes/objGridItem.tscn")

func _ready():
	pass

func _on_wpnPopup_about_to_show():
	for gunName in Globals.gunNameArray:
		if Globals.getUnlocked(gunName):
			var objGridItem = load_objGridItem.instance()
			objGridItem.currentItemName = gunName
			var skinName = Globals.upgs[gunName]["equippedSkin"]
			objGridItem.get_node("sprWeapon").texture = load("res://Assets/Guns/img_" + skinName + ".png")
			objGridItem.connect("item_selected", get_parent(), "setWeaponSlot")
			$vBox/gridCtn.add_child(objGridItem)
