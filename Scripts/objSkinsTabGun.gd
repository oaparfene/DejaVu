extends Tabs

var skinName
var gunName

var skinPopup

var load_skinPopup = preload("res://Scenes/skinPopup.tscn")
var load_purchasePopup = preload("res://Scenes/purchasePopup.tscn")

func _ready():
	gunName = Globals.getGunName()
	skinName = gunName

func _on_objSkinDisplay_pressed():
	skinPopup = load_skinPopup.instance()
	skinPopup.setItemType("gun")
	add_child(skinPopup)
	skinPopup.popup_centered()

func setSkin(input_skinName):
	skinName = input_skinName
	skinPopup.queue_free()
	get_tree().call_group("unlockUI","updateUI")

func updateUI():
	if gunName != Globals.getGunName():
		gunName = Globals.getGunName()
		skinName = gunName
		get_parent().get_parent().get_node("texGun").texture = load("res://Assets/Guns/img_" + skinName + ".png")
	
	$labSkinName.text = skinName
	$objSkinDisplay/Sprite.texture = load("res://Assets/Guns/img_" + skinName + ".png")

	if Globals.upgs[gunName]["skinList"][skinName] == 1:
		Globals.setSkin(gunName, skinName)
		$btnSkin.text = "equipped"
		$btnSkin.disabled = true
	else:
		$btnSkin.text = "unlock"
		$btnSkin.disabled = false


func _on_btnSkin_pressed():
	var resPath = "res://Assets/Guns/img_" + skinName + ".png"
	var purchasePopup = load_purchasePopup.instance()
	purchasePopup.configure(resPath, skinName, Globals.getSkinCostIRL(gunName, skinName), Globals.getSkinCostCoins(gunName, skinName), gunName)
	add_child(purchasePopup)
	purchasePopup.popup_centered()
