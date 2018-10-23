extends Control

onready var textlabel = get_node("TestBox/RichTextLabel")

func _ready():
	hide()
	textlabel.set_process_input(false)
	pass
func set_script_path(path):
	textlabel.scriptPath = path
func start_dialogue():
#	set_script_path(path)
	show()
	textlabel.enter()
	pass
func end_dialogue():
	hide()
#	get_parent().get_node("Player").canMove = true
func _process(delta):
	pass
