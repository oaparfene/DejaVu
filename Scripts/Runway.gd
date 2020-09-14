extends Control

var load_bodyCarEnemy = preload("res://Scenes/bodyCarEnemy.tscn")

var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()



func _on_Timer_timeout():
	var bodyCarEnemy = load_bodyCarEnemy.instance()
	add_child(bodyCarEnemy)
	bodyCarEnemy.position = Vector2(rng.randf_range(250, 850), rng.randf_range(200, 1300))
	pass # Replace with function body.
