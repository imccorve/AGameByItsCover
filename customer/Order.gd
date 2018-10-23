extends Node

var customer_name
var order_name
var time
var recipe = {}

var timer

var curr_status

enum status {
	unactive,
	waiting,
	brewing,
	milk,
	sugar,
	sold
}

signal timeout_order

func _ready():
	set_physics_process(false)
	curr_status = status.unactive
	pass

func init(rcp, customer_nm):
	time = 5
	recipe = rcp
	customer_name = customer_nm
	setup_gui()

func setup_gui():
	curr_status = status.waiting
	
	timer = get_node("HBoxContainer/Timer")
	timer.set_wait_time(time)
	timer.one_shot = true
	timer.start()
	set_physics_process(true)
	
func set_name(order_name):
	self.order_name = order_name
	get_node("HBoxContainer/Control/OrderName").set_text(order_name)
#	get_node("HBoxContainer/OrderName").add_color_override("font_color", Color(1,0,0))
	
func get_name():
	return order_name
	
func _physics_process(delta):
	get_node("HBoxContainer/TimerLabel").set_text(str(floor(timer.time_left)))
	if timer.time_left <= 0:
		pass
func getRecipe():
	return recipe
func getIngredient(ingredient):
	print(ingredient)
	print("Recipe",recipe)
	return recipe[ingredient]

func _on_Timer_timeout():
	emit_signal("timeout_order",self)
	pass # replace with function body
