extends Camera2D

onready var camTween = get_node("camTween")

func configure():
	var goTo = get_parent().camLocations[Globals.currentCribLocation]
	position = goTo
	align()

func move(locationName):
	Globals.setCurrentCribLocation(locationName)
	var goTo = get_parent().camLocations[locationName]
	camTween.interpolate_property(self, "position", position, goTo, 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)
	camTween.start()
	align()
	pass
