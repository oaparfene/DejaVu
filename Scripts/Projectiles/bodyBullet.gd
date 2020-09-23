extends "res://Scripts/Projectiles/classProjectile.gd"

func _init():
	type = "ballistic"

func impact(kinCollisionInfo):
	kinCollisionInfo.collider.damage(mass*speed)
