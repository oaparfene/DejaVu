extends Control



func _ready():
	pass

func _physics_process(delta):
	
	$ctnViewport/Viewport/ParallaxBackground.scroll_offset += Vector2(0, Globals.speed*delta)
