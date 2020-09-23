extends Button

var skinName
var carName

func configure(input_carName, input_skinName):
	skinName = input_skinName
	carName = input_carName
	$Sprite.texture = load("res://Assets/Cars/img_" + skinName + ".png")
