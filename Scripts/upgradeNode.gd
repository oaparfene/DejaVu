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
	var cost = Globals.getUpgradeCost(upgName)
	$texLevel.texture = load("res://Assets/VanHunter/interface/nitro " + str(level+1) + ".png")
	if not Globals.getUnlocked():
		$btnUpg.disabled = true
		$btnUpg.text = ""
		return
	if level == 5:
		$btnUpg.disabled = true
		$btnUpg.text = "MAX"
	else:
		$btnUpg.disabled = false
		$btnUpg.text = str(cost)+"$"
