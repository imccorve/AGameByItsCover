extends Node

var task = preload("res://Task.tscn")
var player_tasks = []
var all_tasks = {} # a json file of random task

var coffee_options = []

var gui
var player
var nav
var world

func _ready():
	gui = get_node("GUI")
	player = get_node("Player")
	nav = get_node("Navigation2D")
	world = get_node("WorldController/Board")
	coffee_options = world.get_options()
	setup_option_connections()
#	player.connect("click_to_position_signal", nav , "movePlayer")
	createTask()

func setup_option_connections():
#	for i in range(0, coffee_options.size()):
#		coffee_options[0].connect("selected", self, "movePlayer")
	coffee_options[0].connect("selected", self, "movePlayer")
	coffee_options[1].connect("selected", self, "movePlayer")
	coffee_options[2].connect("selected", self, "movePlayer")
	print(coffee_options[2].get_name())
	print(coffee_options[0].get_name())

func createTask():
	var recipe = {'sugar': 'none', 'milk': 'some', 'coffee': 'dark'}
	var new_task = task.instance()
	new_task.init('Task1', 5, recipe)
	new_task.connect("timeout_task", self, "on_task_timer_timeout")
	player_tasks.append(new_task)
	_assignTask(new_task)

func _assignTask(task):
	gui.addTasks(task)

func on_task_timer_timeout(task_caller):
#	print(player_tasks)
	player_tasks.erase(task_caller)
#	print(player_tasks)

func movePlayer(option):
	#send method to GUI (for showing options)
	#send method to Nav (for movement)
#	print("Node sending signal " + option.get_name())
#	print(option.get_name() + "'s position " + str(option.get_position_node()))
#	print(option.get_name() + "'s position " + str(option.position))
#	print("---------------")
	var idx = 0
	print(coffee_options[idx].get_name() + str(coffee_options[idx].get_position_node()))
	print("All positions")
	for i in range(0,coffee_options.size()):
		print(coffee_options[i].get_name() + str(coffee_options[i].get_node("Position2D").position))

	nav.movePlayer(option.get_position_node(), player)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
