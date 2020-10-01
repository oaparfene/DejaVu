extends Node2D

func _ready():
	$sprExplosion.play()
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(
		self, "position",
		position, Vector2(position.x,1920+400),
		3, Tween.TRANS_CUBIC, Tween.EASE_IN
	)
	tween.start()

func configure(mass,carTexture,carRotation):
	$sprExplosion.scale = (30/mass) * Vector2.ONE * 5
	$sprCar.texture = carTexture
	$sprCar.rotation = carRotation

func _on_sndExplosion_finished():
	queue_free()

#func _physics_process(delta):
#	position.y += 0.5 * Globals.roadSpeed*delta
