extends Node

var task = preload("res://Task.tscn")
var task_generator_file = load("res://TaskCreator.gd")
var task_generator
var player_tasks = []
var all_tasks = {} # a json file of random task

var score = 0

var curr_task 
var ingredients_chosen = {'sugar':null, 'milk':null,'coffee':null}

var coffee_options = []
var curr_option
var isSelecting = false

var gui
var player
var nav
var world

enum state {
	making,
	taking_orders
}
var curr_state

func _ready():
	gui = get_node("GUI")
	player = get_node("Player")
	nav = get_node("Navigation2D")
	world = get_node("WorldController/Board")
	
	task_generator = task_generator_file.new()
	task_generator.setup()

	coffee_options = world.get_options()
	setup_option_connections()
#	player.connect("click_to_position_signal", nav , "movePlayer")

	curr_state = state.taking_orders

	

func setup_option_connections():
	world.connect("button_selected", self, "movePlayer")
#	for i in range(0, coffee_options.size()):
#		coffee_options[0].connect("selected", self, "movePlayer")
	# select to move and set status 
#	coffee_options[0].connect("selected", self, "movePlayer")
#	coffee_options[1].connect("selected", self, "movePlayer")
#	coffee_options[2].connect("selected", self, "movePlayer")
#	world.getRegister().connect("selected", self, "createNewSale")
#	nav.connect("done_moving", self, "showOptions")
#	gui.connect("done_selecting", self, "enterOption")
#	print(coffee_options[2].get_name())
#	print(coffee_options[0].get_name())

func createNewSale():
	if !isSelecting:
		print("creating new sale")
		curr_task = task_generator.createTask()
		curr_task.connect("timeout_task", self, "on_task_timer_timeout")
		_assignTask(curr_task)

	# task creator class handles creating tasks and randomly assigning it values + json parsing
	pass
	
func createTask():
	var recipe = {'sugar': 'none', 'milk': 'some', 'coffee': 'dark'}
	var new_task = task.instance()
	new_task.init(recipe, '')
	new_task.connect("timeout_task", self, "on_task_timer_timeout")
#	nav.connect("done_moving", self, "showOptions")
	nav.connect("done_moving", self, "showOptions")
	gui.connect("done_selecting", self, "enterOption")
	player_tasks.append(new_task)
	
	_assignTask(new_task)
	return new_task

func _assignTask(task):
	gui.addTasks(task)
	player_tasks.append(task)

func on_task_timer_timeout(task_caller):
#	print(player_tasks)
#	player_tasks.erase(task_caller)
#	print(player_tasks)
	pass

func movePlayer(option):
	#send method to GUI (for showing options)
	#send method to Nav (for movement)
#	print("Node sending signal " + option.get_name())
#	print(option.get_name() + "'s position " + str(option.get_position_node()))
#	print(option.get_name() + "'s position " + str(option.position))
#	print("---------------")
	if !isSelecting:
#		var idx = 0
#		print(coffee_options[idx].get_name() + str(coffee_options[idx].get_position_node()))
#		print("All positions")
#		for i in range(0,coffee_options.size()):
#			print(coffee_options[i].get_name() + str(coffee_options[i].get_node("Position2D").position))
#
		curr_option = option
		nav.movePlayer(option.get_position_node(), player)
		isSelecting = true
#		gui.setOptions(option.get_position_node(), curr_option.get_name())
#		isSelecting = true

func showOptions():
	print("showing options")
	gui.setOptions(curr_option.get_position_node(), curr_option.get_name(), task_generator.getOption(curr_option.get_name()))
#	isSelecting = true
	
func enterOption(option_chosen, ingredient_step):
	print("Option chosen", option_chosen, ingredient_step)
	ingredients_chosen[ingredient_step.to_lower()] = option_chosen
	isSelecting = false
	if isAllChosen():
		print("done")
		print(ingredients_chosen)
		checkResult()

func isAllChosen():
	var count = 0
	for ingredient in ingredients_chosen.keys():
		if ingredients_chosen[ingredient] != null:
			count += 1
	return count == 3
	
func checkResult():
	for key in ingredients_chosen:
		print("This is a key ", key)
		if ingredients_chosen[key] == curr_task.getIngredient(key):
			score += 1
		ingredients_chosen[key] = null
	gui.updateScore(str(score))
	var next_task = player_tasks.pop_front()
	print(next_task)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
