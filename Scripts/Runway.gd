extends Control

var load_bodyCarEnemy = preload("res://Scenes/bodyCarEnemy.tscn")

var enemyCarArray = ["bad","bad","bad2","bad","bad2","bad2","bad","bad2","bad3"]
#var enemyCarArray = ["bad","bad2","bad3"]

var simul = 2

var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()

func _on_Timer_timeout():
	var enemies = get_tree().get_nodes_in_group("enemy").size()
	if enemies > simul - 1:
		return
	if not enemyCarArray.empty():
		var bodyCarEnemy = load_bodyCarEnemy.instance()
		bodyCarEnemy.configure(Globals.getEnemyCarVariables(enemyCarArray[0]))
		bodyCarEnemy.position = Vector2(rng.randf_range(250, 850), -100 + rng.randi_range(0,1)*1920)
		add_child(bodyCarEnemy)
		enemyCarArray.remove(0)
	else:
		if enemies == 0:
			get_tree().change_scene("res://Scenes/Garage.tscn")
