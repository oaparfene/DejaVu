extends Button

signal coins_purchased(coins, price)

var coins
var price

func _on_btnBuyCoins_pressed():
	emit_signal("coins_purchased", coins, price)
