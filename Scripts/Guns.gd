extends Node

var bodyBullet_load = preload("res://Scenes/bodyBullet.tscn")


var rng = RandomNumberGenerator.new()

func getGunBehaviour(gunData,bodyEntity,targetEntity):
	
	print(bodyEntity.name," fired ",gunData["gunName"])
	var projectiles = []
	
	match gunData["gunName"]:
		
		"pistol":
			
			var relVector = getTargetVector(bodyEntity,targetEntity)
			var bodyBullet = bodyBullet_load.instance()
			bodyBullet.position = bodyEntity.position
			bodyBullet.fireVector = applySpread(relVector,gunData["spread"])
			bodyBullet.rotation = bodyBullet.fireVector.angle()
			bodyBullet.speed = gunData["speed"]
			bodyBullet.mass = float(gunData["damage"])/float(gunData["speed"])
			bodyBullet.set_collision_mask_bit(3,true)
			projectiles.append(bodyBullet)
		
		"shotgun":
			
			for bullet in range(gunData["misc"]):
				var relVector = getTargetVector(bodyEntity,targetEntity)
				var bodyBullet = bodyBullet_load.instance()
				bodyBullet.position = bodyEntity.position
				bodyBullet.fireVector = applySpread(relVector,gunData["spread"])
				bodyBullet.rotation = bodyBullet.fireVector.angle()
				bodyBullet.speed = gunData["speed"]
				bodyBullet.mass = ( float(gunData["damage"])/float(gunData["speed"]) )/float(gunData["misc"])
				bodyBullet.set_collision_mask_bit(3,true)
				projectiles.append(bodyBullet)
	
	return projectiles

func getTargetVector(bodyEntity,targetEntity):
	if Globals.target == null:
		return Vector2(0,-1) # Looking up
	var relVector = targetEntity.position - bodyEntity.position
	return relVector.normalized()

func applySpread(vector,arc):
	rng.randomize()
	var newAngle = rng.randfn(vector.angle(),arc/4.0)
	return Vector2( cos(newAngle) , sin(newAngle) )
	
