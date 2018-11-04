extends Node

var register_pos 
var checkout_pos

var curr_r = 0
var curr_o = 0

func _ready():
	register_pos = get_node("Lineup").get_children()
	checkout_pos = get_node("Checkout").get_children()
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func nextRegPos():
	print(curr_r)
	var res_pos = register_pos[curr_r]
	curr_r += 1
	return res_pos.position

func nextCOPos():
	var res_pos = checkout_pos[curr_o]
	curr_r -= 1
	curr_o += 1
	return res_pos.position
	
func leaveCOPos():
	curr_o -= 1

func exit():
	return get_node("Exit/Exit").position
