extends Control

var load_bodyCarEnemy = preload("res://Scenes/Cars/bodyCarEnemy.tscn")

var enemyCarArray = [
	"toad","toad","virtue","toad","virtue","virtue","toad","virtue","viper",
	"virtue","virtue","viper","toad","virtue","virtue","viper","viper","baron"
	]
#var enemyCarArray = ["bad","bad2","bad3"]

var simul = 2
var rng = RandomNumberGenerator.new()


func _ready():
	var car_load = load("res://Scenes/Cars/"+Globals.getCarName()+".tscn")
	var car = car_load.instance()
	car.position = rect_size/2
	add_child(car)
	get_tree().call_group("healthUI","updateUI",car.health,car.health)

func _on_timerSpawn_timeout():
	var enemies = get_tree().get_nodes_in_group("enemy").size()
	if enemies > simul - 1:
		return
	if not enemyCarArray.empty():
		var bodyCarEnemy = load_bodyCarEnemy.instance()
		bodyCarEnemy.configure(Globals.getEnemyCarVariables(enemyCarArray[0]))
		var spawnY = $camRoad.position.y
		bodyCarEnemy.position = Vector2(rng.randf_range(250, 850), spawnY - 960 + rng.randi_range(0,1)*1920)
		add_child(bodyCarEnemy)
		enemyCarArray.remove(0)
	else:
		if enemies == 0:
			var _currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")
