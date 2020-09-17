extends TextureRect

var resetY

func _ready():
	resetY = rect_position.y

func _physics_process(delta):
	rect_position.y += delta*Globals.roadSpeed
	if rect_position.y > resetY + 810:
		rect_position.y -= 810
