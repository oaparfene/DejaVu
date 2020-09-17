extends Control

var camLocations = {}

func _ready():
	camLocations["Garage"] = $Garage.rect_position
	camLocations["GunShop"] = $GunShop.rect_position
	camLocations["CoinShop"] = $CoinShop.rect_position
	camLocations["EnergyShop"] = $EnergyShop.rect_position
	$CameraCrib.configure()
