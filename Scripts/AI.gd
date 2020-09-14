extends Node

var AIModes = {
	1: {
		"name": "hover_below",
		"hoverOffset": Vector2(0, 250)
	},
	2: {
		"name": "hover_above",
		"hoverOffset": Vector2(0, -250)
	},
	3: {
		"name": "hover_right",
		"hoverOffset": Vector2(0, 250)
	},
	4: {
		"name": "hover_left",
		"hoverOffset": Vector2(0, -250)
	}
}

func _ready():
	pass # Replace with function body.

func get_carVector(mode, position):
	if (Globals.posCarPlayer + AIModes[mode]["hoverOffset"] - position).length() < 50:
		return Vector2(0, 0)
	return (Globals.posCarPlayer + AIModes[mode]["hoverOffset"] - position).normalized()
