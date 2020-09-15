extends KinematicBody2D

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")

var actVector = Vector2.ZERO
var velocity = Vector2.ZERO

var carName
var health
var mass
var maxHealth
var speed
var steer
var fuel
var maxFuel
var armor

func damage(dmg):
	var damage = ( (1-float(armor)/100.0)*dmg ) / 5
	health -= damage
	if "bad" in carName:
		if health <= 0:
			queue_free()
	else:
		get_tree().call_group("healthUI","updateUI",health,maxHealth)
		if health <= 0:
			get_tree().change_scene("res://Scenes/Garage.tscn")
	$prgHealth.value = 100*(float(health)/float(maxHealth))
	#print(name," took ",damage," dmg")

func carCollision(kinCollisionInfo:KinematicCollision2D):
	var impactSpeed = abs(kinCollisionInfo.collider.velocity.dot(kinCollisionInfo.normal)) # Calculate impact
	print(kinCollisionInfo.normal)
	print(name," took ",impactSpeed," impact")
	if impactSpeed > 1: # Ignore small collisions
		var damage = impactSpeed * kinCollisionInfo.collider.mass
#		if "bad" in carName:
#			print(impactSpeed," * ",kinCollisionInfo.collider.mass)
		damage(damage)
		#actVector += kinCollisionInfo.collider.actVector
	actVector = actVector.bounce(kinCollisionInfo.normal)
