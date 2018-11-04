extends Control

onready var textlabel = get_node("TestBox/RichTextLabel")
var textPathName
var canEnd = false
func _ready():
	hide()
	textlabel.set_process_input(false)
	pass
func set_script_path(path):
	textlabel.scriptPath = path
func start_dialogue(textPathName, src):
	get_tree().paused = true
#	set_script_path(path)
	show()
	if src:
		get_node("TestBox/Name").text = src
	else:
		get_node("TestBox/Name").text = "Blue"
	textlabel.enter(textPathName, src)
	pass
func wait_for_end():
	canEnd = true
	
func end_dialogue():
	get_tree().paused = false
	hide()
#	get_parent().get_node("Player").canMove = true
func _process(delta):
	if canEnd == true:
		end_dialogue()
		canEnd = false
	pass
