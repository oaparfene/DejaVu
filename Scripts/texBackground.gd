extends TextureRect

var bgs = ["desert","forest","snow","night"]
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	texture = load("res://Assets/Levels/img_"+bgs[rng.randi_range(0,3)]+".png")

func _physics_process(delta):
	
	rect_position.y += delta*810
	if rect_position.y > 0:
		rect_position.y -= 810
