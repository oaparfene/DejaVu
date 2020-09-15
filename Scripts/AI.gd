extends Node

var states = ["idle","shoot","ram","maintain"]
var rng = RandomNumberGenerator.new()

var heights = {"top":250, "bottom":1250}
var widths = {"left":100,"right":980}

func getBehaviour(state,bodyEntity):
	
	var playerEntity = get_tree().get_nodes_in_group("player")[0]
	var player_relVector = playerEntity.position - bodyEntity.position
	
	bodyEntity.fire = false
	var new_fireVector = player_relVector.normalized()
	var new_carVector = Vector2.ZERO
	
	match state:
		"idle":
			pass
		
		"shoot":
			bodyEntity.fire = true
		
		"ram":
			var collInfo = bodyEntity.move_and_collide(player_relVector,true,true,true)
			if collInfo:
				if "Enemy" in collInfo.collider.name:
					bodyEntity.state = getNewState()
				else:
					new_carVector = player_relVector.normalized()
		"maintain":
			if bodyEntity.position.y < heights["top"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,1)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(0,1)
				else:
					new_carVector = Vector2(0,-1)
			elif bodyEntity.position.y > heights["bottom"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,-1)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(0,-1)
				else:
					new_carVector = Vector2(0,1)
			
			if bodyEntity.position.x < widths["left"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(1,0)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(1,0)
				else:
					new_carVector = Vector2(-1,0)
			elif bodyEntity.position.x > widths["right"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(-1,0)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(-1,0)
				else:
					new_carVector = Vector2(1,0)
	
	bodyEntity.carVector = new_carVector.normalized()
	bodyEntity.fireVector = new_fireVector

func getNewState(state=""):
	rng.randomize()
	var newStates = states.duplicate()
	newStates.remove(state)
	return newStates[rng.randi_range(0,newStates.size()-1)]

