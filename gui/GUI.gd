extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var task1
var timer1
var popup_options

var curr_popup

signal done_selecting

var coffee_options = ['blue Mountain', 'kiliminjaro', 'dark', 'mocha']
var expresso_num_options = ["one shot", "double shot"]

var milk_options = ['none', 'some', 'a little', 'whole']
var sugar_options = ['3 spoonfuls', 'two spoonfuls', 'none']

func _ready():
	popup_options = get_node("PopupMenu")
	popup_options.connect("index_pressed", self, "_popupMenuChoice")

	pass

func updateScore(score):
	get_node("TopGUI/VBoxColumn2/Score").set_text(score)
	
func setText(text):
	print(text)


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
	print("type of ", typeof(task.order_name))
	get_node("TopGUI/Tasks").add_child(task)

func removeOrder(order):
	get_node("TopGUI/Tasks").remove_child(order)
	order.queue_free()
	
func showPopup():
	popup_options.show()

func setOptions(pos, curr_option, coffee_step):
	popup_options.clear()
	popup_options.rect_global_position = pos
#	popup_options.show()
	curr_popup = curr_option
	var option_arr = []
#	if coffee_step == 'Coffee':
#		option_arr = coffee_options
#	if coffee_step == 'Milk':
#		option_arr = milk_options
#	if coffee_step == 'Sugar':
#		option_arr = sugar_options
	for op in coffee_step:
		popup_options.add_item(op)

func _popupMenuChoice(ID):
#	popup_options.hide()
	if ID == 1:
		print("one")
	if ID == 2:
		print("2")
	print(ID)
	emit_signal("done_selecting", popup_options.get_item_text(ID), curr_popup)
	popup_options.hide()

func setIngredients(ingredients):
	var vbox = get_node("TopGUI/VBoxColumn2")
	for child in vbox.get_children():
		if child.is_in_group("ingredient_label"):
			print(ingredients)
			if ingredients[child.name] == null:
				child.text = "Nothing"
			else:
				child.text = ingredients[child.name]
	pass

func clearIngredients():
	var vbox = get_node("TopGUI/VBoxColumn2")
	for child in vbox.get_children():
		if child.is_in_group("ingredient_label"):
			child.text = "Nothing"
	pass

func _process(delta):
	pass
