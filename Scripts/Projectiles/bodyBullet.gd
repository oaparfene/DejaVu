extends "res://Scripts/Projectiles/classProjectile.gd"

func _ready():
	type = "ballistic"

func impact(kinCollisionInfo):
	kinCollisionInfo.collider.damage(mass*speed)
