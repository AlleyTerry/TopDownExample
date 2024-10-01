extends Control

signal dialogue_finished
#first we need to get the json file
@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false


func start():
	print("start")
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	

func load_dialogue():
	#loads the file from our files
	var file = FileAccess.open("res://Assets/Dialogue/BabyDialogue1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	#after reading the previous line this functions goes forward 1 to read the next function in the load func
	#if the number is >= the length of the list, it stops
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialogue_finished")
		return
	
	
	$NinePatchRect/name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']

