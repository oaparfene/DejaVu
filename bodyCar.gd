extends KinematicBody2D

onready var partDirt = get_node("partDirt")
onready var partTyre = get_node("partTyre")

func _ready():
	pass

func _physics_process(delta):
	partDirt.initial_velocity = Globals.parSpeed*delta*17
	move_and_collide(Globals.carVector*delta*Globals.carSpeed)
	partTyre.emitting = Globals.carVector.y > 0
