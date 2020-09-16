extends Button

var popup

func _ready():
	$labDescription.text = "Weapons Slot 1"



func _on_weaponSlot_pressed():
	popup = PopupPanel.new()
	popup.connect("popup_hide", self, "deletePopups")
	var gridCtn = GridContainer.new()
	popup.add_child(gridCtn)
	#for gunIndex in Globals.upgs[]

func deletePopups():
	popup.queue_free()
