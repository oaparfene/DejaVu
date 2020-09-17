extends KinematicBody2D

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")

var carVector = Vector2.ZERO		# Input movement vector
var fireVector = Vector2.ZERO		# Shooting vector

var actVector = Vector2.ZERO		# Trailing movement vector

var velocity = Vector2.ZERO			# Movement vector for move_and_slide
var actVelocity = Vector2.ZERO		# Actual velocity of the car
var prevPos = Vector2.ZERO			# Last car position in _physics_process(delta)
var collidedThisTick = false		# Have we collided with a car this _physics_process(delta)
var appliedForce = Vector2.ZERO		# Any collision force being applied

var team

var carName:String
var health:float
var mass:float
var maxHealth:float
var speed:float
var steer:float
var handling:float
var armor:float
var slots:Dictionary
var slotsFire:Array

var money

func handleMovement(delta):
	
	collidedThisTick = false
	
	prevPos = position
	
	$partDirt.initial_velocity = Globals.roadSpeed*delta*17
	
	actVector += (carVector - actVector)*delta*handling
	appliedForce += (Vector2.ZERO - appliedForce)*delta
	
	velocity.y = actVector.y*speed*(1+int(velocity.y > 0)*0.40)
	velocity.x = actVector.x*steer
	velocity += appliedForce
	
	var _returnedVelocity = move_and_slide(velocity)
	actVelocity = (position-prevPos)/delta
	var noOfCollisions = get_slide_count()
	if get_slide_count() > 0:
		var kinCollisionInfo = get_slide_collision(noOfCollisions-1)
		if kinCollisionInfo: # If we collided
			if "Car" in kinCollisionInfo.collider.name:
				carCollision(kinCollisionInfo)
			elif "Lose" in kinCollisionInfo.collider.name and team == "player":
				var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
	
	$sprBro.rotation = fireVector.angle() # Update bro's aiming position
	$sprCar.rotation = actVector.x/3 # Handle rotation

func damage(dmg):
	if dmg < 0:
		return
	var damage = ( (1-armor/100.0)*dmg ) / 600
	health -= damage
	if team == "enemy":
		if health <= 0:
			Globals.levelMoney += money
			queue_free()
	elif team == "player":
		get_tree().call_group("healthUI","updateUI",health,maxHealth)
		if health <= 0:
			var _currentScene = get_tree().change_scene("res://Scenes/GameOver.tscn")
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
	if -colliderImpulse > mass*30: # Ignore small collisions
		appliedForce += newSpeed*(-normal)
		print(name," took ",-colliderImpulse," impact")
		damage(-colliderImpulse)
