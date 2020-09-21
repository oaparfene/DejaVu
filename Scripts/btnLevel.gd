extends TextureButton

var levelID: int			# e.g. 0
var displayText: String		# e.g. "Desert Wastes"
var background: String		# e.g. "desert"

func configure(levelData):
	levelID = levelData["ID"]
	displayText = levelData["displayName"]
	background = levelData["background"]
	updateUI()

func _on_btnLevel_pressed():
	Globals.currentLevel = levelID
	get_tree().call_group("levelUI","updateUI")

func updateUI():
	var isSelected = Globals.currentLevel == levelID
	modulate.b = int(not isSelected)
	texture_normal = load("res://Assets/Levels/img_"+background+".png")
	$labName.text = displayText
