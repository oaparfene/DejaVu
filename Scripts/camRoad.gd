extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	
	var players = get_tree().get_nodes_in_group("player")
	
	if players.empty():
		return
	
	var player = players[0]
	
	position = player.position
	
	position.x = 540
	position.y = clamp(position.y, -1920+960+600, 1920-960-250)
	
	Globals.camPos = position
