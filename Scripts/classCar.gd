extends KinematicBody2D

onready var partDirt = $partDirt
#onready var partTyre = $partTyre
onready var timerAttack = $timerAttack
onready var sprBro = $sprBro

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")

var carName
var health
var maxHealth
var speed
var steer
var fuel
var maxFuel
var armor

func damage(dmg):
	health -= (1-armor)*dmg
	if health <= 0:
		if carName == "bad":
			queue_free()
	$prgHealth.value = 100*(float(health)/float(maxHealth))
