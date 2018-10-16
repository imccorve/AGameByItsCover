extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
#		var pos = position + offset - ( (texture.get_size() / 2.0) if centered else Vector2() ) # added this 2
		var pos = position
		if centered:
			pos = position - ( (texture.get_size() / 2.0))
		print(Rect2(pos, texture.get_size()).has_point(event.position))
		print(event.position, pos,texture.get_size())
		if Rect2(pos, texture.get_size()).has_point(event.position): # added this
			print('test')
			get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
