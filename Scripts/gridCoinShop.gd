extends GridContainer

var load_objBuyItem = preload("res://Scenes/objBuyItem.tscn")

var coinShopData = {}

func _ready():
	coinShopData = Globals.getCoinShopData() # to do: implement coin shop data
	for offer in coinShopData:
		var objBuyItem = load_objBuyItem.instance()
		objBuyItem.coins = offer["Coins"]
		objBuyItem.get_node("labCoins").text = str(offer["Coins"]) + " Coins"
		objBuyItem.price = offer["Price"]
		objBuyItem.get_node("labPrice").text = "$" + str(offer["Price"])
		add_child(objBuyItem)



