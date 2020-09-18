extends Node

var states = ["shoot","evade","ram"]
#var states = ["evade","shoot"]

var rng = RandomNumberGenerator.new()

var heights = {"top":-600, "bottom":600}
var widths = {"left":-300,"right":300}

var distance = 400

func getBehaviour(bodyEntity,state):
	
	var playerEntity = get_tree().get_nodes_in_group("player")[0]
	var player_relVector = playerEntity.position - bodyEntity.position
	
	bodyEntity.fire = false
	var new_fireVector = player_relVector.normalized()
	var new_carVector = Vector2.ZERO
	
	match state:
		
		"shoot":
			bodyEntity.fire = true
		
		"ram":
			var collInfo = bodyEntity.move_and_collide(player_relVector,true,true,true)
			if collInfo:
				if "Enemy" in collInfo.collider.name:
					bodyEntity.state = getNewState(bodyEntity,state)
				else:
					new_carVector = player_relVector.normalized()
		
		"evade":
			var nearEntity = getClosestEntity(bodyEntity)
			var entity_relVector = nearEntity.position - bodyEntity.position
			new_carVector = -entity_relVector.normalized() * clamp(distance - entity_relVector.length(),0,1)
		
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
			
			if inView(bodyEntity): # If we're in view
				bodyEntity.state = getNewState(bodyEntity,state)
	
	bodyEntity.carVector = new_carVector
	bodyEntity.fireVector = new_fireVector

func getClosestEntity(bodyEntity):
	var entities = get_tree().get_nodes_in_group("avoid").duplicate()
	entities.erase(bodyEntity)
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
	


