extends Panel

var upgName
var level = 1

func _ready():
	pass

func configure(input_upgName):
	upgName = input_upgName
	$labName.text = upgName


func _on_btnUpg_pressed():
	if level == 6:
		return
	level += 1
	$texLevel.texture = load("res://Assets/VanHunter/interface/nitro " + str(level) + ".png")
