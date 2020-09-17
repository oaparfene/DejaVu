extends TextureProgress

var healthFade_load = load("res://Scenes/healthFade.tscn")

func updateUI(health,maxHealth):
	var healthLost = value - health
	max_value = maxHealth
	value = health
	createFade(health,healthLost)

func createFade(health,healthLost):
	var healthLostWidth = rect_size.x * float(healthLost)/max_value
	var healthPos = rect_size.x * float(health)/max_value
	var colorRect = healthFade_load.instance()
	colorRect.rect_size = Vector2(healthLostWidth,rect_size.y)
	colorRect.rect_position = Vector2(healthPos,0)
	add_child(colorRect)
