extends TextureProgress

func updateFuelUI():
	max_value = Globals.carFuel["max"]
	value = Globals.carFuel["current"]
