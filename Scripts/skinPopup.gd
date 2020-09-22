extends PopupPanel

var load_objGridItem = preload("res://Scenes/objGridItem.tscn")
var activeCarName

func _ready():
	activeCarName = Globals.getCarName()



func _on_skinPopup_about_to_show():
	for skinName in Globals.skinNameDict[activeCarName]:
		var objGridItem = load_objGridItem.instance()
		objGridItem.currentItemName = skinName
		objGridItem.get_node("sprWeapon").texture = load("res://Assets/Cars/img_" + skinName + ".png")
		objGridItem.connect("item_selected", get_parent(), "setSkin")
		$vBox/gridCtn.add_child(objGridItem)
