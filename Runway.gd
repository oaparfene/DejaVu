extends Node2D





func _ready():
	pass

func _process(delta):
	$ParallaxBackground.scroll_offset += Vector2(0,300)*delta
