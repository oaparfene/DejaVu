extends Button

signal item_selected(name)

var currentItemName

func _ready():
	pass 

func _on_objGridItem_pressed():
	emit_signal("item_selected", currentItemName)
