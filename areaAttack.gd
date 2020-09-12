extends Area2D

onready var sprCenter = $sprCenter

func _ready():
	pass # Replace with function body.

func _on_areaAttack_input_event(viewport, event, shape_idx):
	
	if event is InputEventScreenDrag:
		
		sprCenter.position = event.position - position
	
	elif event is InputEventScreenTouch:
		
		if event.pressed == false:

			sprCenter.position = Vector2.ZERO
	
	if sprCenter.position.length() > 150:
		sprCenter.position = sprCenter.position.normalized() * 150
	
	Globals.fireVector = sprCenter.position.normalized()
	
	if sprCenter.position.length() > 110:
		Globals.fire = true
	else:
		Globals.fire = false
