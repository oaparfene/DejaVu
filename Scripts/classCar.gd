extends KinematicBody2D

var death_load = preload("res://Scenes/death.tscn")

var carVector = Vector2.ZERO		# Input movement vector
var fireVector = Vector2.ZERO		# Shooting vector

var actVector = Vector2.ZERO		# Trailing movement vector

var velocity = Vector2.ZERO			# Movement vector for move_and_slide
var actVelocity = Vector2.ZERO		# Actual velocity of the car
var prevPos = Vector2.ZERO			# Last car position in _physics_process(delta)
var collidedThisTick = false		# Have we collided with a car this _physics_process(delta)
var appliedForce = Vector2.ZERO		# Any collision force being applied

var team: String
var isPlayer: bool = false

var carName:String
var health:float
var mass:float
var maxHealth:float
var engine:float
var handling:float
var armor:float
var turnRatio:float
var slots:Dictionary
var gunNames:Array
var skinName:String

var money

func _ready():
	add_to_group("car")

func setCollision():
	set_collision_layer_bit(Globals.teamBits[team],true)
	set_collision_mask_bit(9,true)
	for otherTeam in Globals.teamBits:
		set_collision_mask_bit(Globals.teamBits[otherTeam],true)

func handleMovement(delta):
	
	collidedThisTick = false
	
	prevPos = position
	
	$partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	actVector += (carVector - actVector)*delta*handling
	appliedForce += (Vector2.ZERO - appliedForce)*delta
	
	velocity.y = actVector.y*engine*(1+int(velocity.y > 0)*0.40)
	velocity.x = actVector.x*engine*turnRatio
	velocity += appliedForce
	
	var _returnedVelocity = move_and_slide(velocity)
	actVelocity = (position-prevPos)/delta
	var kinCollisionInfo
	var noOfCollisions = get_slide_count()
	if noOfCollisions > 0:
		kinCollisionInfo = get_slide_collision(noOfCollisions-1)
		if kinCollisionInfo: # If we collided
			if "Car" in kinCollisionInfo.collider.name:
				carCollision(kinCollisionInfo)
			elif "Lose" in kinCollisionInfo.collider.name and isPlayer:
				var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
	
	$sprBro.rotation = fireVector.angle() # Update bro's aiming position
	$sprCar.rotation = actVector.x/3 # Handle rotation
	
	return kinCollisionInfo

func damage(dmg):
	
	if dmg < 0:
		return
	
	if Globals.invincible and isPlayer:
		dmg = 0
	
	var damage = ( (1-armor/100.0)*dmg )
	health -= damage
	
	if isPlayer:
		get_tree().call_group("healthUI","updateUI",health,maxHealth)
		if health <= 0:
			var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
	else:
		if health <= 0:
			Globals.levelMoney += money
			var death = death_load.instance()
			death.position = position
			death.configure(mass,$sprCar.texture,actVector.x/3)
			get_parent().add_child(death)
			queue_free()
	
	$prgHealth.value = 100*(health/maxHealth)
	#print(name," took ",damage," dmg")


func carCollision(info:KinematicCollision2D):
	calculateCollision(info.normal,info.collider.actVelocity,info.collider.mass)
	info.collider.calculateCollision(-info.normal,actVelocity,mass)

func calculateCollision(normal,other_actVelocity,other_mass):
	# Check if we've collided this turn
	if collidedThisTick == true:
		return
	collidedThisTick = true
	
	var colliderSpeed = -other_actVelocity.dot(normal) # Calculate impact
	var ourSpeed = -actVelocity.dot(normal)
	var newSpeed = ( 1*other_mass*(colliderSpeed-ourSpeed) + mass*ourSpeed + other_mass*colliderSpeed )/( mass + other_mass )
	var colliderImpulse = colliderSpeed * other_mass
	if -colliderImpulse > mass*20: # Ignore small collisions
		appliedForce += newSpeed*(-normal)
		#print(name," took ",-colliderImpulse," impact")
		damage(-colliderImpulse/600)
