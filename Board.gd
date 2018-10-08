extends Node

var coffee_button
var milk_button
var sugar_button

func _ready():
	coffee_button = get_node("BaristaArea/Coffee")
	milk_button = get_node("BaristaArea/Milk")
	sugar_button = get_node("BaristaArea/Sugar")


#        var pos = position + offset - ( (texture.get_size() / 2.0) if centered else Vector2() ) # added this 2
#        if Rect2(pos, texture.get_size()).has_point(event.position): # added this
#            print('test')
#            get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass




func _on_Coffee_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed):
		print("Clicked")
