extends KinematicBody2D

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")

var actVector = Vector2.ZERO
var velocity = Vector2.ZERO

var team

var carName:String
var health:float
var mass:float
var maxHealth:float
var speed:float
var steer:float
var handling:float
var armor:float

var money

func damage(dmg):
	var damage = ( (1-armor/100.0)*dmg ) / 5
	health -= damage
	if team == "enemy":
		if health <= 0:
			Globals.levelMoney += money
			queue_free()
	elif team == "player":
		get_tree().call_group("healthUI","updateUI",health,maxHealth)
		if health <= 0:
			var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
	$prgHealth.value = 100*(health/maxHealth)
	#print(name," took ",damage," dmg")

func carCollision(info:KinematicCollision2D):
	var enemy = info.collider
	var impactSpeed = abs(enemy.velocity.dot(info.normal)) # Calculate impact
	var impactImpulse = impactSpeed * enemy.mass
	var newImpulse = velocity.dot(info.normal) - impactImpulse
	var newSpeed = newImpulse/mass
	actVector *= newSpeed/speed
	#print(name," took ",impactSpeed," impact")
	if impactSpeed > 5: # Ignore small collisions
		var damage = impactSpeed * enemy.mass
		damage(damage)
	#actVector = actVector.bounce(info.normal)*(enemy.mass/(enemy.mass+mass))
