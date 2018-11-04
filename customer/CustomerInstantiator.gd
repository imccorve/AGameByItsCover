extends Node

var customer = load("res://customer/Customer.tscn")

signal customer_arrives

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


func _on_Timer_timeout():
	print("timer new customer")
	emit_signal("customer_arrives")
	pass # replace with function body
