extends KinematicBody2D

var events = {}
onready var partDirt = get_node("partDirt")


func _ready():
	pass


func _physics_process(delta):
	partDirt.initial_velocity = Globals.speed*delta*17
	pass

func _input(event):

	
	if not(event is InputEventScreenTouch or event is InputEventScreenDrag or event is InputEventMouseButton):
		return
	
	if event is InputEventScreenTouch:
		
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)
	
	
	elif event is InputEventScreenDrag:
		
		events[event.index] = event
		
		# The user is dragging ONE finger across the viewport (DRAG)
		if events.size() == 1:
			move_and_collide(event.relative)
