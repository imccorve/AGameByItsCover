extends Area2D

var disabled = false

signal selected

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func disable():
	disabled = true
func enable():
	disabled = false
func get_position_node():
	return $Position2D.global_position

# Had to click Ignore Mouse in Control

func _on_Sugar_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and !disabled:
		emit_signal("selected", self)
