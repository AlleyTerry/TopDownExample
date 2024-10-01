extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer
@onready var itemOne : TextureRect = $HBoxContainer/LevelOneItem
@onready var itemTwo : TextureRect = $HBoxContainer/LevelTwoItem
@onready var itemThree : TextureRect = $HBoxContainer/LevelThreeItem
@onready var itemFour : TextureRect = $HBoxContainer/LevelFourItem
@onready var itemFive : TextureRect = $HBoxContainer/LevelFiveItem

func _ready():
	AudioPlayer.play_bedroom_scene()
	AudioPlayer.process_mode = Node.PROCESS_MODE_ALWAYS
	showObtainedItems()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	startDialogue()

func startDialogue():
	if GameState.currentLevel == 1:
		Dialogic.signal_event.connect(_on_dialogic_signal)
		#Dialogic.start("Playertimeline")
		var dialog = Dialogic.start("BedroomOpening")
		dialog.process_mode= Node.PROCESS_MODE_ALWAYS
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
	elif GameState.currentLevel == 2:
		#add dialog when level 1 is finished
		Dialogic.signal_event.connect(_on_dialogic_signal)
		var dialog = Dialogic.start("level1Bedroom")
		dialog.process_mode= Node.PROCESS_MODE_ALWAYS
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
	elif GameState.currentLevel == 3:
		Dialogic.signal_event.connect(_on_dialogic_signal)
		var dialog = Dialogic.start("level2Bedroom")
		dialog.process_mode= Node.PROCESS_MODE_ALWAYS
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
	elif GameState.currentLevel == 4:
		Dialogic.signal_event.connect(_on_dialogic_signal)
		var dialog = Dialogic.start("level3Bedroom")
		dialog.process_mode= Node.PROCESS_MODE_ALWAYS
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
	elif GameState.currentLevel == 5:
		Dialogic.signal_event.connect(_on_dialogic_signal)
		var dialog = Dialogic.start("level4Bedroom")
		dialog.process_mode= Node.PROCESS_MODE_ALWAYS
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
	
func showObtainedItems():
	if GameState.itemOneObtained:
		$Items/LevelOneItem.visible = true
	if GameState.itemTwoObtained:
		$Items/LevelTwoItem.visible = true
	if GameState.itemThreeObtained:
		$Items/LevelThreeItem.visible = true
	if GameState.itemFourObtained:
		$Items/LevelFourItem.visible = true
	if GameState.itemFiveObtained:
		$Items/LevelFiveItem.visible = true

func _on_go_to_level_body_entered(body):
	#this function switched to the first level once the player hits the area2D
	#it plays a fade in animation and then waits the duration of that animation before changing scenes
	if body is AbstractPlayer:
		SceneTransitionAnimation.play("fadeIn")
		await get_tree().create_timer(0.4).timeout
		if GameState.currentLevel == 1:
			get_tree().change_scene_to_file("res://Scenes/level_1_denial.tscn")
		elif GameState.currentLevel == 2:
			get_tree().change_scene_to_file("res://Scenes/level_2_anger.tscn")
		elif GameState.currentLevel == 3:
			get_tree().change_scene_to_file("res://Scenes/level_3_bargain.tscn")
		elif GameState.currentLevel == 4:
			get_tree().change_scene_to_file("res://Scenes/level_4_depression.tscn")
		elif GameState.currentLevel == 5:
			get_tree().change_scene_to_file("res://Scenes/level_5_acceptance.tscn")


func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false
