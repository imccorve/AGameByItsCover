extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var marker
var player_path
var goal
var end
var anim

var numGoals
var currClicks

var clicked = false
signal done
signal pouring

func _ready():
	anim = get_parent().get_node("AnimationPlayer")
	marker = get_node("Marker")
	player_path = get_node("PlayerPath")
	goal = get_node("Goal")
	end = (get_node("BG").rect_position + get_node("BG").rect_size).x
	setParams(300, 4)
	player_path.hide()

func setParams(start, end):
	goal.rect_position = Vector2(start, 0)
	goal.rect_size += Vector2(40 * end, 0)
	
	numGoals = 1
	currClicks = 0

func giveResults():
	var score = 0
	score += goal.rect_position.x - player_path.rect_position.x
	score += goal.rect_size.x - player_path.rect_size.x
	return score

func _process(delta):
	if clicked:
		player_path.rect_size += Vector2(4,0)
	if marker.rect_position.x > end:
		print("reached the end")
		emit_signal("done", giveResults())
	else:
		marker.rect_position += Vector2(4, 0)

func _input(event):
	if currClicks < numGoals:
		if event.is_action_pressed('click'):
			if !clicked:
				player_path.show()
				clicked = true
				player_path.rect_position = marker.rect_position
				anim.play("pour")
				emit_signal("pouring")
	
		if event.is_action_released('click'):
			clicked = false
			currClicks += 1
			anim.play_backwards("pour")

			#using particles for the milk liquid and a shader for the coffee liquid
			print("Here is end ", end)
			print("Here is marker", marker.rect_position.x)
			print(player_path.rect_position)
			print(goal.rect_position)
			print(player_path.rect_size)
			print(goal.rect_size)




