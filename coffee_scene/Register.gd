extends Area2D

signal selected

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_position_node():
	return $Position2D.global_position
#	return $Position2D.position
	
func _on_Register_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("selected", self)
	pass # replace with function body
