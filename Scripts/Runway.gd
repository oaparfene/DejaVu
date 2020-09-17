extends Control

var load_bodyCarEnemy = preload("res://Scenes/bodyCarEnemy.tscn")

var enemyCarArray = [
	"toad","toad","virtue","toad","virtue","virtue","toad","virtue","viper",
	"virtue","virtue","viper","toad","virtue","virtue","viper","viper","baron"
	]
#var enemyCarArray = ["bad","bad2","bad3"]

var simul = 3

var rng = RandomNumberGenerator.new()
func _ready():
	var car_load = load("res://Scenes/Cars/"+Globals.getCarName()+".tscn")
	var car = car_load.instance()
	car.position = rect_size/2
	add_child(car)
	$prgHealth.updateUI(car.health,car.health)
	
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
			var _currentScene = get_tree().change_scene("res://Scenes/Garage.tscn")

func setPlayerCarVector(vector):
	get_tree().call_group("player","areaMove_changed",vector)

func _on_btnFire_pressed():
	get_tree().call_group("player","btnFire_pressed")

func _on_btnFire_released():
	get_tree().call_group("player","btnFire_released")
