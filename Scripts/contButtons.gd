extends HBoxContainer

var currentScene
onready var camera = get_parent().get_node("ctnViewport/Viewport/CribInner/CameraCrib")

func _ready():
	updateUI()

func updateUI():
	$btnCoins.text = str(Globals.money) + "$"

func _on_btnCars_pressed():
	camera.move("Garage")

func _on_btnGuns_pressed():
	camera.move("GunShop")

func _on_btnEnergy_pressed():
	camera.move("EnergyShop")

func _on_btnCoins_pressed():
	camera.move("CoinShop")
