extends PopupPanel

var load_objGridItem = preload("res://Scenes/objGridItem.tscn")
var activeItemName
var itemType

func setItemType(input_itemType):
	if input_itemType == "car": 
		itemType = "Cars"
		activeItemName = Globals.getCarName()
		#rect_position = Vector2(80, 0)
	else:
		itemType = "Guns"
		activeItemName = Globals.getGunName()
		#rect_position = Vector2(80, 0) 

func _on_skinPopup_about_to_show():
	for skinName in Globals.skinNameDict[activeItemName]:
		var objGridItem = load_objGridItem.instance()
		objGridItem.currentItemName = skinName
		objGridItem.get_node("sprWeapon").texture = load("res://Assets/" + itemType + "/img_" + skinName + ".png")
		objGridItem.connect("item_selected", get_parent(), "setSkin")
		$vBox/gridCtn.add_child(objGridItem)
