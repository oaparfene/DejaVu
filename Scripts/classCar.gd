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
	var damage = ( (1-armor/100.0)*dmg ) / 200
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

func carCollision(info:KinematicCollision2D,delta:float):
	var enemy = info.collider
	var colliderImpulse = -enemy.velocity.dot(info.normal) * enemy.mass # Calculate impact
	var impulse = -velocity.dot(info.normal) * mass
	var newImpulse = impulse + colliderImpulse
	var newSpeed = newImpulse/mass
	print(
		team,"(",mass,") ",
		"S:",stepify(-velocity.dot(info.normal),0.1)," I:",stepify(impulse,0.1),
		" -> ",
		"I:",stepify(colliderImpulse,0.1)," S:",stepify(-enemy.velocity.dot(info.normal),0.1),
		" (",enemy.mass,")"+enemy.team
	)
	print(team,": [ nS:",newSpeed," nI:",newImpulse,"]")
	print(team," Before: ",actVector)
	actVector = actVector.normalized()*clamp(newSpeed/(speed*delta),-1,1)
	print(team," After: ",actVector)
	#print(name," took ",impactSpeed," impact")
	if impulse > 0: # Ignore small collisions
		enemy.damage(impulse)
	#actVector = actVector.bounce(info.normal)*(enemy.mass/(enemy.mass+mass))
