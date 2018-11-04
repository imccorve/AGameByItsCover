extends Navigation2D

#var path = []
#var player
var characters_moving = {} # char and path

signal done_moving

func _ready():
	set_process(false)
	pass

func movePlayer(dest, character):
	print("<<< Moving player dest ", character.name, dest, character.position)
#	_update_navigation_path(character.position, dest) 
#	_update_navigation_path(character.position, get_local_mouse_position()) 
#	player = character
	characters_moving[character] = _update_navigation_path(character.position, dest) 
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _update_navigation_path(start_pos, end_pos):
	var path = get_simple_path(start_pos, end_pos, true)
	print("<< path ", path)
	path.remove(0)
	set_process(true)
	return path
	
func _process(delta):
#	var walk_distance = player.speed * delta
#	move_along_path(walk_distance)
	for player in characters_moving:
		var walk_distance = player.speed * delta
		move_along_path(walk_distance, player, characters_moving[player])
	
func move_along_path(distance, player, path):
	var last_point = player.position
	for index in range(path.size()):
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points and distance >= 0.0:
			player.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			break
		elif distance < 0.0:
			player.position = path[0]
			characters_moving.erase(player)
			set_process(false)
			break
		distance -= distance_between_points
		last_point = path[0]
		print("LastPoint ",last_point)
		path.remove(0)
		characters_moving[player] = path
	if path.size() == 0:
		emit_signal("done_moving",player)
		characters_moving.erase(player)
		if characters_moving.empty():
			set_process(false)
		