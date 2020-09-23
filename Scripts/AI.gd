extends Node

var states = ["shoot","evade","ram"]
#var states = ["evade","shoot"]

var rng = RandomNumberGenerator.new()

var heights = {"top":-600, "bottom":600}
var widths = {"left":-300,"right":300}

var distance = 400

func getEnemies(team):
	var entities = get_tree().get_nodes_in_group("car")
	var allies = get_tree().get_nodes_in_group(team)
	var enemies = []
	for entity in entities:
		if not entity in allies:
			enemies.append(entity)
	return enemies

func getBehaviour(bodyEntity,state):
	
	var _allAllies = get_tree().get_nodes_in_group(bodyEntity.team).duplicate()
	var allEnemies = getEnemies(bodyEntity.team).duplicate()
	
	var targetEntity = null
	var target_relVector = Vector2(0,-1)
	
	if not allEnemies.empty():
		targetEntity = getTargetEntity(bodyEntity,allEnemies)
		target_relVector = targetEntity.position - bodyEntity.position
	else:
		bodyEntity.state = "maintain"
		state = "maintain"
	
	bodyEntity.fire = false
	bodyEntity.target = null
	var new_fireVector = target_relVector.normalized()
	var new_carVector = Vector2.ZERO
	
	match state:
		
		"shoot":
			bodyEntity.target = targetEntity
			bodyEntity.fire = true
			
			# If we're out of ammo
			if bodyEntity.ammo == 0:
				bodyEntity.state = getNewState(bodyEntity,"shoot")
				bodyEntity.ammo = bodyEntity.maxAmmo
		
		"ram":
			bodyEntity.target = targetEntity
			var collInfo = bodyEntity.move_and_collide(target_relVector,true,true,true)
			if collInfo:
				if "Car" in collInfo.collider.name:
					# If we've got a teammate in the way OR we are about to ram our target
					if bodyEntity.team == collInfo.collider.team:
						bodyEntity.state = getNewState(bodyEntity,"ram")
				new_carVector = target_relVector.normalized()
		
		"evade":
			var nearEntity = getClosestEntity(bodyEntity)
			if not nearEntity:
				return
			var entity_relVector = nearEntity.position - bodyEntity.position
			new_carVector = -entity_relVector.normalized() * clamp(distance - entity_relVector.length(),0,1)
			# If we've evaded
			if new_carVector == Vector2.ZERO:
				bodyEntity.state = getNewState(bodyEntity,"evade")
		
		"maintain":
			if bodyEntity.position.y - Globals.camPos.y < heights["top"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,1)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(0,1)
				else:
					new_carVector = Vector2(0,-1)
			elif bodyEntity.position.y - Globals.camPos.y > heights["bottom"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,-1)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(0,-1)
				else:
					new_carVector = Vector2(0,1)
			
			if bodyEntity.position.x - Globals.camPos.x < widths["left"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(1,0)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(1,0)
				else:
					new_carVector = Vector2(-1,0)
			elif bodyEntity.position.x - Globals.camPos.x > widths["right"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(-1,0)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(-1,0)
				else:
					new_carVector = Vector2(1,0)
			
			# If we're in view
			if inView(bodyEntity):
				bodyEntity.state = getNewState(bodyEntity,"maintain")
	
	bodyEntity.carVector = new_carVector
	bodyEntity.fireVector = new_fireVector

func getTargetEntity(bodyEntity,enemyEntities):
	if enemyEntities.empty():
		return
	var target = enemyEntities[0]
	for entity in enemyEntities:
		if bodyEntity.position.distance_to(entity.position) < bodyEntity.position.distance_to(target.position):
			target = entity
	return target

func getClosestEntity(bodyEntity):
	var entities = get_tree().get_nodes_in_group("car").duplicate()
	entities.erase(bodyEntity)
	if entities.empty():
		return
	var closest = entities[0]
	for entity in entities:
		if entity == bodyEntity:
			continue
		elif bodyEntity.position.distance_to(entity.position) < bodyEntity.position.distance_to(closest.position):
			closest = entity
	return closest

func getNewState(bodyEntity,state=""):
	rng.randomize()
	var newState = ""
	if not inView(bodyEntity):
		newState = "maintain"
	else:
		var newStates = states.duplicate()
		newStates.erase(state)
		newState = newStates[rng.randi_range(0,newStates.size()-1)]
		
	#print(bodyEntity.name," is now in ",newState," mode")
	return newState

func inView(bodyEntity):
	
	if bodyEntity.position.y - Globals.camPos.y < heights["top"] or bodyEntity.position.y - Globals.camPos.y > heights["bottom"]:
		return false
	if bodyEntity.position.x - Globals.camPos.x < widths["left"] or bodyEntity.position.x - Globals.camPos.x > widths["right"]:
		return false
	
	return true
	


