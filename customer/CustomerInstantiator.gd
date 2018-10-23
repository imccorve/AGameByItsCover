extends Node

var customer = load("res://customer/Customer.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func createCustomer(pos):
	var customer_inst = customer.instance()
	customer_inst.setup()
	customer_inst.global_position = pos
	return customer_inst
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
