extends AnimatedSprite

func _ready():
	play()
	$sndBoom.play()

func _on_sndBoom_finished():
	queue_free()
