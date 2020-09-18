extends Sprite

func _ready():
	$sndBoom.play()

func _physics_process(delta):
	modulate.a -= delta*3


func _on_sndBoom_finished():
	queue_free()
