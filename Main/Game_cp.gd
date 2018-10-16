extends Node

var score = 0

var player 
var gui
var world
var nav
var custo_init

var curr_order
var ingredients_chosen = {'sugar':null, 'milk':null,'coffee':null}

var isSelecting = false
var canMove = true 
var completing_order = false

var waiting_customers = []

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
	setup_connections()
	for i in range(0,2):
		addCustomers()
	pass

func setup_connections():
	world.connect("button_selected", self, "buttonAction")
	nav.connect("done_moving", self, "showGUI")
	gui.connect("done_selecting", self, "enterOption")
	
func addCustomers():
	var new_customer = custo_init.createCustomer()
	waiting_customers.append(new_customer)
	new_customer.print_info()
	
	
func buttonAction(button):
	if canMove:
		canMove = false
		print("<<< Button pos ", button.get_position_node())
		nav.movePlayer(button.get_position_node(), player)

		if button.is_in_group("option"):
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

func takeCustomer(): # or take all the waiting customers
	while (waiting_customers):
		var new_customer = waiting_customers.pop_front()
		print("Waiting customers", waiting_customers)
		world.takeCustomer(new_customer)
		gui.addTasks(new_customer.getOrder())
		if curr_order == null:
			curr_order = world.getCurrentOrder()
#	if waiting_customers.empty():
#		print("Return - Done with level and waiting customers is empty")
#		return
	if curr_order:
		print("Curr node ", curr_order.recipe)
	else:
		print ("No current node")


func showGUI():
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
			takeCustomer()
		# show customer take text and take customer method
		pass

func enterOption(option_chosen, ingredient):
	isSelecting = false
	canMove = true
	print("Option chosen", option_chosen, ingredient)
	ingredients_chosen[ingredient.to_lower()] = option_chosen
#	isSelecting = false
#	if isAllChosen():
#		print("done")
#		print(ingredients_chosen)
#		checkResult()

func checkResult():
	print("Checking ingredients in result ", curr_order)
	print(ingredients_chosen)
	var compare_recipe = curr_order.getRecipe()
	print(curr_order.getRecipe())
	for key in ingredients_chosen:
		if ingredients_chosen[key] == compare_recipe[key]:
			score += 20
		ingredients_chosen[key] = null
		
	gui.updateScore(str(score))
	gui.removeOrder(curr_order)
	# pop off another order
	curr_order = world.getCurrentOrder()
	print("New curr order ", curr_order)

func removeCustomer():
	pass
#func _process(delta):
#	print(get_local_mouse_position())
#	pass
