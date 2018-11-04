extends Node
# handles picking and choosing ingredients

#var coffee_button
#var milk_button
#var sugar_button
#var barista_area
#var register
const capacity = 4
var selectables = [] 

var orders_list = []
var taken_customers = []

signal button_selected

func _ready():
#	barista_area = get_node("BaristaArea")
#	coffee_button = get_node("BaristaArea/Coffee")
#	milk_button = get_node("BaristaArea/Milk")
#	sugar_button = get_node("BaristaArea/Sugar")
#	register = get_node("Register")
	
	# move character then execute action
	# stack of actions and pop nav from stack when done and then perform next action (in game file)
	for button in get_tree().get_nodes_in_group("destination"):
		button.connect("selected", self, "buttonSelected")
#	milk_button.connect("selected", self, "movePlayer")
#	sugar_button.connect("selected", self, "movePlayer")
#
#	register.connect("selected", self, "movePlayer")
	
func buttonSelected(button):
	emit_signal("button_selected", button)

func getSelectableButtons():
	return selectables

func takeCustomer(customer):
	customer.createOrder()
	orders_list.append(customer.getOrder())
	taken_customers.append(customer)
	return customer.getOrder()

func removeCustomer():
	return taken_customers.pop_front()
func gettakenCustomersSz():
	return taken_customers.size()
func canTakeMoreCustomers():
	return taken_customers.size() < capacity

func addToOrderList(order):
	orders_list.append(order)

func getCurrentOrder():
	print(orders_list)
	var curr_order = orders_list.pop_front()
	if curr_order:
		return curr_order
	else:
		print("No Orders")
		return


