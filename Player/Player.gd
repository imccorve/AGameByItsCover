extends KinematicBody2D


export (int) var speed = 300

var velocity = Vector2()
var target = Vector2()
var cup

signal click_to_position_signal


func _ready():
	target = get_position()
	cup = get_node("SpriteBody/CoffeCup")
	hideCup()
	pass

func showCup():
	cup.show()
	
func hideCup():
	cup.hide()

	

#func get_input():
#	velocity = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		velocity.x += 1
#	if Input.is_action_pressed('ui_left'):
#		velocity.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1
#	velocity = velocity.normalized() * speed
#
#func _physics_process(delta):
#    get_input()
#    move_and_slide(velocity)

# Click and move
#
#func _input(event):
#	if event.is_action_pressed('click'):
#		target = get_global_mouse_position()
#		emit_signal("click_to_position_signal", position, self)
#
#func _physics_process(delta):
#	velocity = (target - position).normalized() * speed
#	# rotation = velocity.angle()
#	if (target - position).length() > 5:
#		move_and_slide(velocity)