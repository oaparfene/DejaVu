extends Control

func _ready():
	pass # Replace with function body.



func _on_labPlay_pressed():
	get_tree().change_scene("res://Runway.tscn")

func _on_labGarage_pressed():
	get_tree().change_scene("res://Garage.tscn")
