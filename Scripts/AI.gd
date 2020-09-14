extends Node

var states = ["idle","shoot","ram","maintain"]
var rng = RandomNumberGenerator.new()

var heights = {"top":250, "bottom":1250}

func getBehaviour(state,bodyEntity):
	
	var playerEntity = get_tree().get_nodes_in_group("player")[0]
	var player_relVector = playerEntity.position - bodyEntity.position
	
	bodyEntity.fire = false
	var new_fireVector = Vector2.ZERO
	var new_carVector = Vector2.ZERO
	
	match state:
		"idle":
			pass
		
		"shoot":
			bodyEntity.fire = true
			new_fireVector = player_relVector.normalized()
		
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
			elif bodyEntity.position.y > heights["bottom"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,-1)*50,true,true,true)
				if not collInfo:
					new_carVector = Vector2(0,-1)
			else:
				bodyEntity.state = getNewState()
	
	bodyEntity.carVector = new_carVector.normalized()
	bodyEntity.fireVector = new_fireVector

func getNewState(_state=""):
	rng.randomize()
	return states[rng.randi_range(0,states.size()-1)]

