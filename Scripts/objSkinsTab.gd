extends Tabs

var skinName
var carName

var skinPopup

var load_skinPopup = preload("res://Scenes/skinPopup.tscn")

func _ready():
	carName = Globals.getCarName()
	skinName = carName

func _on_objSkinDisplay_pressed():
	skinPopup = load_skinPopup.instance()
	add_child(skinPopup)
	skinPopup.popup_centered()

func setSkin(input_skinName):
	skinName = input_skinName
	get_tree().call_group("unlockUI","updateUI")
	skinPopup.queue_free()

func updateUI():
	if carName == Globals.getCarName():
		$objSkinDisplay/Sprite.texture = load("res://Assets/Cars/img_" + skinName + ".png")
	else:
		carName = Globals.getCarName()
		skinName = carName
		$objSkinDisplay/Sprite.texture = load("res://Assets/Cars/img_" + skinName + ".png")
		get_parent().get_parent().get_node("texCar").texture = load("res://Assets/Cars/img_" + skinName + ".png")
