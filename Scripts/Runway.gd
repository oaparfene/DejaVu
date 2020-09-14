extends Control

var load_bodyCarEnemy = preload("res://Scenes/bodyCarEnemy.tscn")

var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()



func _on_Timer_timeout():
	var bodyCarEnemy = load_bodyCarEnemy.instance()
	bodyCarEnemy.position = Vector2(rng.randf_range(250, 850), -100 + rng.randi_range(0,1)*1920)
	add_child(bodyCarEnemy)
