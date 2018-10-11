extends "res://InteractableSprite.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


#func _on_Interactable_Sprite_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.pressed:
#		emit_signal("selected", self)
#		print("cooolio")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Register_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("coolio")
		emit_signal("selected")
	pass # replace with function body
