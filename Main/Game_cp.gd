extends Node

var score = 0

var player 
var gui
var world
var nav
var custo_init
var positonsCustomers

var curr_order
var button_selected
var ingredients_chosen = {'sugar':null, 'milk':null,'coffee':null}

var isSelecting = false
var canMove = true 
var completing_order = false

var waiting_customers = []
const capacity = 4

var pour_scene = load("res://MiniGame/MiniGame.tscn")

func _ready():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	OrderGenerator.setup()
	player = get_node("Player")
	gui = get_node("GUI")
	nav = get_node("Navigation2D")
	world = get_node("WorldController")
	custo_init = get_node("CustomerInstantiator")
	positonsCustomers = get_node("PositionsForCustomers")
#
	get_node("transition_effect").play(true)

	get_node("Dialogue").start_dialogue("scenes.json", null)

	setup_connections()
	for i in range(0,2):
		addCustomers()
		
	

func setup_connections():
	world.connect("button_selected", self, "buttonAction")
	nav.connect("done_moving", self, "showGUI")
	gui.connect("done_selecting", self, "enterOption")
	custo_init.connect("customer_arrives", self, "addCustomers")
	
func addCustomers():
	if waiting_customers.size() + world.gettakenCustomersSz() < 4:
		print(waiting_customers.size())
		print(waiting_customers.size() + world.gettakenCustomersSz())
		var pos = get_node("CustPosition").position
		
		var new_customer = custo_init.createCustomer(pos)
		
		waiting_customers.append(new_customer)
		add_child_below_node(player, new_customer)
		print("child added")
		var reg_pos = positonsCustomers.nextRegPos()
		print("reggs_pos ", reg_pos)
		nav.movePlayer(reg_pos, new_customer)
		new_customer.print_info()
	
	
func buttonAction(button):
	if canMove:
		button_selected = button.name
		canMove = false
		print("<<< Button pos ", button.get_position_node())
		nav.movePlayer(button.get_position_node(), player)

		if button.is_in_group("option"):
			player.showCup()
			isSelecting = true
			gui.setOptions(button.get_position_node(), button.get_name(), OrderGenerator.getOption(button.get_name()))
		else:
			if button.name == "PickupArea":
				completing_order = true
			# set up text hidden
			if button.name == "Register":
				# eventually call after text is finished
				pass
#				takeCustomer()
			gui.setText("")

func showGUI(character_moved):
	print("Character moved ", character_moved)
	print("<<< Player pos after move ",player.position)
	if isSelecting:
		gui.showPopup()
	else:
		canMove = true # after text
		if completing_order == true and curr_order:
			checkResult()
			completing_order = false
			pass
		else:
			print("taking customer in showgui")
			if character_moved.is_in_group("player") and button_selected == "Register":
				takeCustomer()
			if character_moved.is_in_group("tobedeleted"):
				deleteCustomer(character_moved)
		# show customer take text and take customer method
		pass


func takeCustomer(): # or take all the waiting customers
#	while (waiting_customers):
	if (waiting_customers):
		var new_customer = waiting_customers.pop_front()
		print("Waiting customers", waiting_customers)
		world.takeCustomer(new_customer)
		gui.addTasks(new_customer.getOrder())
		if curr_order == null:
			curr_order = world.getCurrentOrder()
		# send customers to pickuparea
		var check_pos = positonsCustomers.nextCOPos()
		print("check_pos ", check_pos)
		nav.movePlayer(check_pos, new_customer)
	#	if waiting_customers.empty():
	#		print("Return - Done with level and waiting customers is empty")
	#		return
		get_node("Dialogue").start_dialogue("scenes.json", new_customer.getName())
	if curr_order:
		print("Curr node ", curr_order.recipe)
	else:
		print ("No current node")

func enterOption(option_chosen, ingredient):
	isSelecting = false
	canMove = true
	print("Option chosen", option_chosen, ingredient)
	ingredients_chosen[ingredient.to_lower()] = option_chosen
	gui.setIngredients(ingredients_chosen)
	if ingredient.to_lower() == "milk":
		startPourMilk()

func checkResult():
	player.hideCup()
	print("Checking ingredients in result ", curr_order)
	print(ingredients_chosen)
	var compare_recipe = curr_order.getRecipe()
	print(curr_order.getRecipe())
	for key in ingredients_chosen:
		if ingredients_chosen[key] == compare_recipe[key]:
			score += 20
		ingredients_chosen[key] = null
		
	gui.updateScore(str(score))
	# call method in curr_order to signal to its owner that it's completed
	gui.removeOrder(curr_order)
	# pop off another order
	curr_order = world.getCurrentOrder()
	print("New curr order ", curr_order)
	gui.clearIngredients()
	get_node("Dialogue").start_dialogue("scenes.json", "Departure")
	removeCustomer()

func removeCustomer():
	positonsCustomers.leaveCOPos()
	var served_customer = world.removeCustomer()
	served_customer.add_to_group("tobedeleted")
	nav.movePlayer(positonsCustomers.exit(), served_customer)
	pass
func deleteCustomer(customer):
	customer.queue_free()
#func _process(delta):
#	print(get_local_mouse_position())
#	pass

func disableInput():
	for node in get_tree().get_nodes_in_group("destination"):
		node.disable()
	pass
func enableInput():
	for node in get_tree().get_nodes_in_group("destination"):
		node.enable()
		
func startPourMilk():
	print("Pouring milk")
	var pour_scene_inst = pour_scene.instance()
	add_child(pour_scene_inst)
	pour_scene_inst.connect("done", self, "endPourMilk", [pour_scene_inst])

func endPourMilk(results, arr):
	arr.queue_free()
	print("Here are results ", results)
	
	
func _on_Button_pressed():

#	get_node("transition_effect").play(true)
	get_node("Dialogue").start_dialogue()

	pass # replace with function body
func _process(delta):
   if Input.is_action_pressed("key_exit"):
      get_tree().quit()