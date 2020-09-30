extends Panel

var upgName: String
var cribLocation: int

func configure(location,upgName_pass):
	upgName = upgName_pass
	cribLocation = location
	$labName.text = upgName + ":"
	updateUI()

func _on_btnUpg_pressed():
	
	match cribLocation:
		0:
			Globals.upgradeCar(upgName)
		1:
			Globals.upgradeGun(upgName)
		2:
			print("you just pressed a nonexistent button.... how?")
		3:
			print("you just pressed a nonexistent button.... how?")
		_:
			print("invalid crib location")
	updateUI()

func updateUI():
	match cribLocation:
		0:
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
		1:
			var level = Globals.getUpgradeLevel(upgName, Globals.getGunName())
			var cost = Globals.getGunUpgradeCost(upgName)
			$texLevel.texture = load("res://Assets/VanHunter/interface/nitro " + str(level+1) + ".png")
			if not Globals.getUnlocked(Globals.getGunName()):
				$btnUpg.disabled = true
				$btnUpg.text = ""
				return
			if level == 5:
				$btnUpg.disabled = true
				$btnUpg.text = "MAX"
			else:
				$btnUpg.disabled = false
				$btnUpg.text = str(cost)+"$"
		2:
			print("you just pressed a nonexistent button.... how?")
		3:
			print("you just pressed a nonexistent button.... how?")
		_:
			print("invalid crib location")
	
