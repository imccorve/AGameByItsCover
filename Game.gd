extends Node

var task = preload("res://Task.tscn")
var player_tasks = []
var all_tasks = {} # a json file of random task

var gui
var player

func _ready():
	gui = get_node("GUI")
	createTask()
	pass

func createTask():
	var recipe = {'sugar': 'none', 'milk': 'some', 'coffee': 'dark'}
	var new_task = task.instance()
	new_task.init('Task1', 5, recipe)
	new_task.connect("timeout_task",self, "on_task_timer_timeout")
	player_tasks.append(new_task)
	
	_assignTask(new_task)
	pass

func _assignTask(task):
	gui.addTasks(task)
	
func on_task_timer_timeout(task_caller):
	print(player_tasks)
	player_tasks.erase(task_caller)
	print(player_tasks)
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
