extends Control

func setPlayerCarVector(vector):
	get_tree().call_group("player","areaMove_changed",vector)

func _on_btnFire_pressed():
	get_tree().call_group("player","btnFire_pressed")

func _on_btnFire_released():
	get_tree().call_group("player","btnFire_released")
