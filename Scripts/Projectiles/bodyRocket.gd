extends "res://Scripts/Projectiles/classProjectile.gd"

onready var sprExplosion_load = preload("res://Scenes/Projectiles/sprExplosion.tscn")

var aoe:float

func _ready():
	type = "rocket"

func impact(_kinCollisionInfo):
	var sprExplosion = sprExplosion_load.instance()
	sprExplosion.position = position
	sprExplosion.scale = Vector2.ONE * (aoe/500)
	get_parent().add_child(sprExplosion)
	for entity in get_tree().get_nodes_in_group("enemy")+get_tree().get_nodes_in_group("player"):
		var relVector = entity.position - position
		var prox = relVector.length()
		if prox <= aoe:
			entity.damage((1-prox/aoe)*(mass*speed))
			entity.appliedForce += relVector.normalized()*speed*(1-prox/aoe)
	queue_free()

