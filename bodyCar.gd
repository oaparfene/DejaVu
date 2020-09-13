extends KinematicBody2D

onready var partDirt = $partDirt
onready var partTyre = $partTyre
onready var timerAttack = $timerAttack

var bodyBullet_load = preload("res://bodyBullet.tscn")

func _ready():
	timerAttack.wait_time = 0.1

func _physics_process(delta):
	partDirt.initial_velocity = Globals.parSpeed*delta*17
	move_and_collide(Globals.carVector*delta*Globals.carSpeed)
	partTyre.emitting = Globals.carVector.y > 50


func _on_timerAttack_timeout():
	if Globals.fire == true:
		var bodyBullet = bodyBullet_load.instance()
		bodyBullet.position = position + Globals.fireVector*100
		bodyBullet.rotation = Globals.fireVector.angle()
		bodyBullet.fireVector = Globals.fireVector
		bodyBullet.speed = 30
		get_parent().add_child(bodyBullet)
