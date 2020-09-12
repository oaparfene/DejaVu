extends Control



func _ready():
	pass

func _physics_process(delta):
	
	$ParallaxBackground.scroll_offset += Vector2(0, Globals.parSpeed*delta)
