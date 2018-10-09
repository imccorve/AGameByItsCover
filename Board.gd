extends Node

var coffee_button
var milk_button
var sugar_button
var barista_area

func _ready():
	barista_area = get_node("BaristaArea")
	coffee_button = get_node("BaristaArea/Coffee")
	milk_button = get_node("BaristaArea/Milk")
	sugar_button = get_node("BaristaArea/Sugar")

func get_options():
	var options = []
	
	print(barista_area.get_children())
	for i in barista_area.get_children():
		print (i.get_name())
	# must convert other sprites to are2d
	return barista_area.get_children()
#	options.append(barista_area.get_child(2))
#	return options
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

