extends RichTextLabel

var TwineScript = preload("twine_script.gd")
var optionsPanel

#export(String, FILE, "*.json") var scriptPath = "res://dialogue/text/intro.json"
export(String, FILE, "*.json") var scriptPath = "res://dialogue/text/scenes.json"

var script
var currentPassage 
var currentParagraph = 0
var isChoosing = false

signal finished

func enter():
	var DialogueManager = get_parent().get_parent()
	self.connect("finished", DialogueManager, "end_dialogue")
	optionsPanel = get_parent().get_node("Options/ItemList")
	script = TwineScript.new(scriptPath)
	script.parse()
	currentPassage = script.get_start_node()

	show_paragraph(currentPassage)

	set_process_input(true)
	
func _input(event):
#	if(event.is_action_pressed("ui_accept") && !isChoosing):
	if(event.is_action_pressed("click") && !isChoosing):
		print("pressing and not choosing ", currentPassage, script.is_end(currentPassage))
		if script.has_next(currentPassage):
			currentPassage = script.get_next(currentPassage)
			show_paragraph(currentPassage)
		else:
			exit()


#	elif(event.is_action_pressed("ui_accept") && isChoosing):
	elif(event.is_action_pressed("click") && isChoosing):
		# get chosen option then link /get_next based on linkpath && save to json if flag
		if optionsPanel.get_selected_items().size() > 0:
			# + 1 becuase content is in spot 0
			var index = optionsPanel.get_selected_items()[0] + 1
			# move to next (or end) based on selection

			optionsPanel.clear()
			optionsPanel.hide()
			isChoosing = false
			if(script.has_next_option(currentPassage, index)):
				currentPassage = script.get_next_option(currentPassage, index)
				show_paragraph(currentPassage)
			else:
				exit()
		pass
		
func show_paragraph(currPassage):
	
	var passage
	print("Showing passage ", currPassage)
	if(script.has_passage(currPassage)):
		passage = script.get_passage(currPassage)
	else:
		print("it's not there")
		
	# set flag and check flag
	script.set_flag(currPassage)
	var condition_cleared = script.check_flag_condition(currPassage)
	set_bbcode(passage.content[0])
	

	# potentially show options 
	isChoosing = script.has_options(currPassage)
	print("isChoosing variable ", isChoosing)
	if(isChoosing):
		# show options on optionspanel and don't move to next until chosen
		optionsPanel.show()
		optionsPanel.grab_focus()
		print(script.get_passage(currentPassage)["content"][2].option)
#		var options = (script.get_passage(currentPassage))["content"]
		var options = script.get_options(currentPassage)
		for option in options:
			optionsPanel.add_item(option)
		pass

func exit():
	emit_signal("finished")
	set_process_input(false)
	print("done")


func _on_story_meta_clicked(meta):
	print("Link clicked: ", meta)
	var sectionId = int(meta.split('_')[1])
	currentPassage = sectionId
	currentParagraph = 0
	show_paragraph(currentPassage, currentParagraph)