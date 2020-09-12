extends Area2D

onready var sprCenter = $sprCenter

func _ready():
	pass # Replace with function body.

func _on_areaMove_input_event(viewport, event, shape_idx):
	
	
	if event is InputEventScreenDrag:
		
		sprCenter.position = event.position - position
		if sprCenter.position.length() > 150:
			sprCenter.position = sprCenter.position.normalized() * 150
	
	elif event is InputEventScreenTouch:
		
		if event.pressed == false:

			$sprCenter.position = Vector2.ZERO
	
	Globals.carVector = sprCenter.position
