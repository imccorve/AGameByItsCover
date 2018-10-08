extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var task1
var timer1

func _ready():
	pass

func addTasks(task):
#
#	var label = Label.new()
#	var timer = Timer.new()
#	label.set_text(task.get_name() + " " + str(task.time))
#	label.add_color_override("font_color", Color(1,0,0,1))
#	timer.set_wait_time(500)
#	timer.start()
#	get_node("TopGUI/Tasks").add_child(label)
#	get_node("TopGUI/Tasks").add_child(timer)
#	task1 = label
#	timer1 = timer
	get_node("TopGUI/Tasks").add_child(task)
	pass
	
func _process(delta):
	
	pass
