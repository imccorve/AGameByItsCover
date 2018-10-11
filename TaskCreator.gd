extends Node

var task = preload("res://Task.tscn")

var json_file
var game_info
var game_info_json_path = "res://game_info.json"

var customers
var coffee_options


func setup():
	parseJSON(game_info_json_path)
#	load_file_as_JSON("res://game/dialogue/events.json", events)
#	load_file_as_JSON("res://game/dialogue/choices.json", choices)
	var directory = Directory.new();
	var doFileExists = directory.file_exists(game_info_json_path)
	print(doFileExists)
	
	# Test
	generateRecipe()

func parseJSON(file_path):
	var data_file = File.new()
	if data_file.open(file_path, File.READ) != OK:
		print("Can't Read")
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		print("Can't Parse")
		return
	game_info = data_parse.result
	
	customers = game_info["customers"]
	coffee_options = game_info["coffee_options"]
	
func createTask():
	var recipe = generateRecipe()
	var new_task = task.instance()
	new_task.init(recipe, randCustomer())
#	_assignTask(new_task)
	return new_task
func randCustomer():
	return customers[randi()%customers.size()+0]
func generateRecipe():
	var recipe = {}
	print(coffee_options["sugar"].size())
	recipe["sugar"] = coffee_options["sugar"][randi()%coffee_options["sugar"].size()+0]
	recipe["coffee"] = coffee_options["coffee"][randi()%coffee_options["coffee"].size()+0]
	recipe["milk"] = coffee_options["milk"][randi()%coffee_options["milk"].size()+0]
	return recipe

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
