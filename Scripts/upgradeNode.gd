extends Panel

var upgName

func _ready():
	upgName = name.right(7).to_lower()
	$labName.text = upgName
	updateUI()

func _on_btnUpg_pressed():
	Globals.upgrade(upgName)
	updateUI()

func updateUI():
	var level = Globals.getUpgradeLevel(upgName)
	$texLevel.texture = load("res://Assets/VanHunter/interface/nitro " + str(level+1) + ".png")
	Globals.saveGame()
