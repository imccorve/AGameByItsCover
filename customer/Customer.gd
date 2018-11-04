extends Node

var order = preload("Order.tscn")

var customer_info_json
var customer_order
var customer_name
var customer_sprite

var speed = 200


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setup():
	# set name
	# set order
	customer_info_json = OrderGenerator.randCustomer()
	customer_name = customer_info_json["name"]
	setName()
	pass

func createOrder():
	var new_order = order.instance()
	new_order.init(OrderGenerator.generateRecipe(), customer_name)
	new_order.set_name(customer_info_json["task"])
	customer_order = new_order

func setName():
	if customer_name:
		get_node("Name").text = customer_name
	else:
		print("name is null")
func getName():
	return customer_name

func setSprite(sprite):
	customer_sprite = sprite
	
#func setOrder(order):
#	customer_order = order

func getOrder():
	return customer_order

func print_info():
	print("Customer ", customer_info_json)
	print("Cusotme's order ", customer_order)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
