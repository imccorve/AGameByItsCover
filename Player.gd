extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


export (int) var speed = 200

var velocity = Vector2()
var target = Vector2()

func _ready():
	target = get_position()
	pass
	
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

func _input(event):
	if event.is_action_pressed('click'):
		target = get_global_mouse_position()
		print(target)

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	# rotation = velocity.angle()
	if (target - position).length() > 5:
		move_and_slide(velocity)