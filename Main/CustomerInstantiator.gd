extends Node

var customer = load("res://customer/Customer.gd")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func createCustomer():
	var customer_inst = customer.new()
	customer_inst.setup()
	return customer_inst
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
