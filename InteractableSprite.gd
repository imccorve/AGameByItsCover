extends Area2D

signal selected

func _ready():
	connect("input_event", self, "_on_Interactable_Sprite_input_event")
	pass

func get_position_node():
	return $Position2D.global_position

func _on_Interactable_Sprite_input_event(viewport, event, shape_idx):
	pass
#	func _on_Interactable_Sprite_input_event():
#	pass
#	if event is InputEventMouseButton and event.pressed:
#		emit_signal("selected", self)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
