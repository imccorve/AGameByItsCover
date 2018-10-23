extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func play(transition_in):
	show()
	if transition_in:
		get_node("AnimationPlayer").play("transition_in")
	else:
		get_node("AnimationPlayer").play("transition_out")



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	hide()
	pass # replace with function body
