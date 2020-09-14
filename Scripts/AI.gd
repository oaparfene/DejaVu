extends Node

var states = ["idle","shoot","ram","maintain"]
var rng = RandomNumberGenerator.new()

var heights = {"top":250, "bottom":1250}

func getBehaviour(state,bodyEntity):
	
	var playerEntity = get_tree().get_nodes_in_group("player")[0]
	var player_relVector = playerEntity.position - bodyEntity.position
	bodyEntity.fire = false
	
	match state:
		"idle":
			bodyEntity.carVector = Vector2(0,0)
		
		"shoot":
			bodyEntity.fire = true
			bodyEntity.fireVector = player_relVector.normalized()
		
		"ram":
			var collInfo = bodyEntity.move_and_collide(player_relVector,true,true,true)
			if collInfo:
				if "Enemy" in collInfo.collider.name:
					bodyEntity.state = getNewState()
				else:
					bodyEntity.carVector = player_relVector.normalized()
		"maintain":
			if bodyEntity.position.y < heights["top"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,1)*50,true,true,true)
				if not collInfo:
					bodyEntity.carVector = Vector2(0,1)
			elif bodyEntity.position.y > heights["bottom"]:
				var collInfo = bodyEntity.move_and_collide(Vector2(0,-1)*50,true,true,true)
				if not collInfo:
					bodyEntity.carVector = Vector2(0,-1)
			else:
				bodyEntity.carVector = Vector2(0,0)
				bodyEntity.state = getNewState()

func getNewState(_state=""):
	rng.randomize()
	return states[rng.randi_range(0,states.size()-1)]

