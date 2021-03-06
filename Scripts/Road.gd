extends Control

var load_bodyCarEnemy = preload("res://Scenes/Cars/bodyCarEnemy.tscn")

var basePain: int
var enemyCarArray = [
	"toad","toad","virtue","toad","virtue","virtue","toad","virtue","viper",
	"virtue","virtue","viper","toad","virtue","virtue","viper","viper","baron"
	]
#var enemyCarArray = ["bad","bad2","bad3"]

var simul = 3
var rng = RandomNumberGenerator.new()


func _ready():
	
	# Load Level
	var levelData = Globals.getCurrentLevel()
	enemyCarArray = levelData["enemyList"]
	$texRoad.texture = load("res://Assets/Levels/img_"+levelData["background"]+".png")
	basePain = levelData["basePain"]
	
	# Load Car
	var car_load = load("res://Scenes/Cars/"+Globals.getCarName()+".tscn")
	var car = car_load.instance()
	car.position = rect_size/2
	add_child(car)
	get_tree().call_group("healthUI","updateUI",car.health,car.health)
	Globals.target = null
	

func _on_timerSpawn_timeout():
	
	# Get the Array of enemies
	var enemies = AI.getEnemies("survivor")
	var noOfEnemies = enemies.size()
	
	# Cap number of enemies
	if noOfEnemies > simul - 1:
		return
	
	var pain = 0
	for enemy in enemies:
		pain += enemy.pain
	
	# Cap amount of pain
	if pain >= basePain and noOfEnemies != 0:
		return
	
	# End game if all enemies are dead
	if enemyCarArray.empty():
		if noOfEnemies == 0:
			Globals.gainLevelReward()
			Globals.unlockNextLevel()
			var _currentScene = get_tree().change_scene("res://Scenes/GameWin.tscn")
		return
	
	# Spawn enemy car
	var spawnData = enemyCarArray[0]
	var bodyCarEnemy = load_bodyCarEnemy.instance()
	
	# Set team name
	if spawnData.has("team"):
		bodyCarEnemy.team = spawnData["team"]
	else:
		bodyCarEnemy.team = "merc"
	
	# Configure
	bodyCarEnemy.configure(Globals.getEnemyCarVariables(spawnData["carName"]))
	
	# Check if boss
	if spawnData.has("boss"):
		bodyCarEnemy.pain = 999
	
	# Spawn in random position
	var spawnY = $camRoad.position.y
	rng.randomize()
	bodyCarEnemy.position = Vector2(rng.randf_range(250, 850), spawnY - 960 + rng.randi_range(0,1)*1920)
	
	# Add to scene
	add_child(bodyCarEnemy)
	enemyCarArray.remove(0)
	
	Globals.getTarget()


func _on_sndTheme_finished():
	$sndTheme.play(9.125)

#func _physics_process(delta):
#	$camRoad/Label.text = str(Globals.target)



