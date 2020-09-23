extends PopupPanel

var resPath
var itemName
var costIRL
var costCoins
var activeItemName

func configure(input_resPath, input_itemName, input_costIRL, input_costCoins, input_activeItemName):
	resPath = input_resPath
	itemName = input_itemName
	costIRL = input_costIRL
	costCoins = input_costCoins
	activeItemName = input_activeItemName

func _on_purchasePopup_about_to_show():
	$vBox/texItem.texture = load(resPath)
	$vBox/lab.text = "Purchase " + itemName + "?"
	if costIRL < 0:
		$vBox/btnBuyIRL.visible = false
	else:
		$vBox/btnBuyIRL.text = "$" + str(costIRL)
	if costCoins < 0:
		$vBox/btnBuyCoins.visible = false
	else:
		$vBox/btnBuyCoins.text = str(costCoins) + " Coins"

func _on_btnBuyIRL_pressed(): # implement IAPs here
	print("IAPs currently still in development")
	queue_free()

func _on_btnBuyCoins_pressed():
	if Globals.purchaseCoins(costCoins):
		Globals.upgs[activeItemName]["skinList"][itemName] = 1 # unlock item
		Globals.saveGame()
		get_tree().call_group("unlockUI","updateUI")
		queue_free()
	else:
		print("Insufficient funds")
