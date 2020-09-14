extends Control

var load_bodyCarEnemy = preload("res://Scenes/bodyCarEnemy.tscn")

func _ready():
	pass




func _on_Timer_timeout():
	var bodyCarEnemy = load_bodyCarEnemy.instance()
	add_child(bodyCarEnemy)
	bodyCarEnemy.position = Vector2(350, 950)
	pass # Replace with function body.
