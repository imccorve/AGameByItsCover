extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# Had to click Ignore Mouse in Control

func _on_Coffee_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clicked")
