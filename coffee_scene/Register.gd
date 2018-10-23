extends Area2D

var disabled = false

signal selected

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func disable():
	disabled = true
func enable():
	disabled = false
func get_position_node():
	return $Position2D.global_position
#	return $Position2D.position
	
func _on_Register_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and !disabled:
		emit_signal("selected", self)
	pass # replace with function body
