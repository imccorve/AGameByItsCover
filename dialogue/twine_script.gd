extends Object

var passages
var data = {}
var scriptPath
var initial
var dialogue_owner

func _init(jsonPath, test):
	scriptPath = jsonPath
	dialogue_owner = test


func parse():
	print(scriptPath)
	var directory = Directory.new();
	var doFileExists = directory.file_exists(scriptPath)
	print("Does file exist ", doFileExists)
	data = load_json(scriptPath)

	if dialogue_owner == null:
		initial = data["data"].initial
	
		var passage = {}
		passage = data["data"]["stitches"][initial].content
		passages = data["data"]["stitches"]
	else:
		initial = data[dialogue_owner].initial
	
		var passage = {}
		passage = data[dialogue_owner]["stitches"][initial].content
		passages = data[dialogue_owner]["stitches"]

func load_json(json_path):
	var data = {}
	var jsonFile = File.new()
	jsonFile.open(json_path, jsonFile.READ)
	
	if(jsonFile.get_error()):
		print("Error while reading: ", json_path)
		return data
	
	var text = jsonFile.get_as_text()
	data = parse_json(text)
	jsonFile.close()
	return data

func get_story_name():
	return data["name"]

func get_passages():
	return passages

func get_passage_names():
	var passageNames = []
	for pid in passages:
		var passage = passages[pid]
		if(passage.has("name")):
			passageNames.append(passage["name"])
		else:
			passageNames.append("Name not found!")
	return passageNames

func get_passage(passageName):
	if(passages.has(passageName)):
		return passages[passageName]
	else:
		return {"text": "Error: Passage #"+str(passageName)+" not found"}
		
func is_end(passageName):
	print("Checking if end" , passages[passageName]["content"][1].has("isEnd"))
	return passages[passageName]["content"][1].has("isEnd")

func has_passage(passageName):
	return passages.has(passageName)
func has_options(passageName):
	print("Has options ",passages[passageName]["content"][1].has("option"))
	if get_content(passageName).size() > 1 and get_content(passageName)[1].has("option"):
		return true
	return false
	
func get_options(passageName):
	var options = []
	for idx in range(1, get_content(passageName).size()):
		if get_content(passageName)[idx].has("option"):
			options.append(get_content(passageName)[idx]["option"])
	return options
#divert to next passage (for now)
func has_next(currPassage):
	print(get_content(currPassage).size())
	if get_content(currPassage).size() <= 1:
		return false
	elif get_content(currPassage)[1].has("divert"):
		return true
	else:
		return false
		
func get_next(currPassage):
	print(passages[currPassage]["content"])
	return get_content(currPassage)[1]["divert"]

func has_next_option(currPassage, index):
	if get_content(currPassage)[index]["linkPath"] == null:
		return false
	return true
func get_next_option(currPassage, index):
	print(passages[currPassage]["content"][index]["linkPath"])
	return passages[currPassage]["content"][index]["linkPath"]
	
func get_start_node():
#	return data["startNode"]
	print(data["data"].initial)
	return data["data"].initial
	
func moreThanOne(currPassage):
	if get_content(currPassage).size() > 1:
		return true 
	else:
		return false

func set_flag(passageName):

	var last = get_content(passageName).size() - 1
	print("LASTTT ", get_content(passageName)[last])
	if get_content(passageName)[last].has("flagName"):
		print("set flag")

func check_flag_condition(passageName):
	var last = get_content(passageName).size() - 1
	if get_content(passageName)[last].has("ifCondition"):
		print("check flag")
		return false 
	return true
func get_content(passageName):
	return passages[passageName]["content"]