extends Control

var load_upgradeNode = preload("res://upgradeNode.tscn")
var upgradeNode

func _ready():
	upgradeNode = load_upgradeNode.instance()
	upgradeNode.configure("Engine")
	upgradeNode.rect_position = Vector2(50, 250)
	add_child(upgradeNode)
	upgradeNode = load_upgradeNode.instance()
	upgradeNode.configure("Steering")
	upgradeNode.rect_position = Vector2(670, 250)
	add_child(upgradeNode)
	upgradeNode = load_upgradeNode.instance()
	upgradeNode.configure("Armor")
	upgradeNode.rect_position = Vector2(50, 1100)
	add_child(upgradeNode)
	upgradeNode = load_upgradeNode.instance()
	upgradeNode.configure("Fuel")
	upgradeNode.rect_position = Vector2(670, 1100)
	add_child(upgradeNode)

func _on_Button_pressed():
	get_tree().change_scene("res://MenuScene.tscn")


func _on_btnGuns_pressed():
	get_tree().change_scene("res://GunShop.tscn")


func _on_btnCoins_pressed():
	get_tree().change_scene("res://CoinsShop.tscn")


func _on_btnEnergy_pressed():
	get_tree().change_scene("res://EnergyShop.tscn")
