extends Tabs

var skinName
var carName

var skinPopup

var load_skinPopup = preload("res://Scenes/skinPopup.tscn")
var load_purchasePopup = preload("res://Scenes/purchasePopup.tscn")

func _ready():
	carName = Globals.getCarName()
	skinName = Globals.getItemSkin(carName)

func _on_objSkinDisplay_pressed():
	skinPopup = load_skinPopup.instance()
	skinPopup.setItemType("car")
	add_child(skinPopup)
	skinPopup.popup_centered()

func setSkin(input_skinName):
	skinName = input_skinName
	skinPopup.queue_free()
	get_tree().call_group("unlockUI","updateUI")

func updateUI():
	if carName != Globals.getCarName():
		carName = Globals.getCarName()
		skinName = Globals.getItemSkin(carName)
		get_parent().get_parent().get_node("texCar").texture = load("res://Assets/Cars/img_" + skinName + ".png")
	
	$labSkinName.text = skinName
	$objSkinDisplay/Sprite.texture = load("res://Assets/Cars/img_" + skinName + ".png")
	
	if Globals.upgs[carName]["skinList"][skinName] == 1:
		Globals.setSkin(carName, skinName)
		$btnSkin.text = "equipped"
		$btnSkin.disabled = true
	else:
		$btnSkin.text = "unlock"
		$btnSkin.disabled = false


func _on_btnSkin_pressed():
	var resPath = "res://Assets/Cars/img_" + skinName + ".png"
	var purchasePopup = load_purchasePopup.instance()
	purchasePopup.configure(resPath, skinName, Globals.getSkinCostIRL(carName, skinName), Globals.getSkinCostCoins(carName, skinName), carName)
	add_child(purchasePopup)
	purchasePopup.popup_centered()
