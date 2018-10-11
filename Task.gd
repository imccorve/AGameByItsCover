extends Node

var customer
var task_name
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

signal timeout_task

func _ready():
	curr_status = status.unactive
	pass

func init(rcp, cust):
	task_name = cust.task
	time = 5
	recipe = rcp
	customer = cust
	setup_gui()

func setup_gui():
	curr_status = status.waiting
	timer = get_node("HBoxContainer/Timer")
	timer.set_wait_time(time)
	timer.one_shot = true
	timer.start()
	get_node("HBoxContainer/TaskName").set_text(task_name)
	
func set_name(tsk_name):
	task_name = tsk_name
	
func get_name():
	return task_name
	
func _physics_process(delta):
	get_node("HBoxContainer/TimerLabel").set_text(str(floor(timer.time_left)))
	if timer.time_left <= 0:
		pass

func getIngredient(ingredient):
	print(ingredient)
	print("Recipe",recipe)
	return recipe[ingredient]

func _on_Timer_timeout():
	emit_signal("timeout_task",self)
	pass # replace with function body
