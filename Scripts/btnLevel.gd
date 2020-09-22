extends TextureButton

var levelID: int			# e.g. 0
var displayText: String		# e.g. "Desert Wastes"
var background: String		# e.g. "desert"
var basePain: int
var reward: int

var texCar_load = load("res://Scenes/texCar.tscn")

func configure(levelData):
	levelID = levelData["ID"]
	displayText = levelData["displayName"]
	background = levelData["background"]
	for enemy in levelData["enemyList"]:
		var texRect = texCar_load.instance()
		texRect.texture = load("res://Assets/Cars/img_"+enemy["carName"]+".png")
		$Cars.add_child(texRect)
	basePain = levelData["basePain"]
	reward = levelData["reward"]
	updateUI()

func _on_btnLevel_pressed():
	if Globals.isLevelUnlocked(levelID):
		Globals.setLevel(levelID)
		get_tree().call_group("levelUI","updateUI")

func updateUI():
	if not Globals.isLevelUnlocked(levelID):
		modulate = Color(0.1,0.1,0.1)
		$Cars.visible = false
		return
	else:
		modulate = Color(1,1,1)
		$Cars.visible = true
	var isSelected = Globals.currentLevel == levelID
	self_modulate.b = int(not isSelected)
	texture_normal = load("res://Assets/Levels/img_"+background+".png")
	$labName.text = displayText + " {" + str(basePain) + "}"
	$labReward.text = "Reward: " + str(reward) + "$"
