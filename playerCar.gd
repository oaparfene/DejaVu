extends KinematicBody2D


var events = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
