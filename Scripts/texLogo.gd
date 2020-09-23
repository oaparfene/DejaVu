extends TextureRect

onready var timer = $timer

func _physics_process(delta):
	rect_position.y = sin(2*PI*timer.time_left)*1000*delta

func _on_timer_timeout():
	timer.start()
