extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer
@onready var HealthBar = $UICanvasLayer/UI/HealthBar
@onready var GhostsRemaining = $UICanvasLayer/UI/GhostsRemainingLabel

func _ready():
	AudioPlayer.play_level_five_scene()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	startDialogue()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _process(delta):
	HealthBar.value = GameState.player_health
	GhostsRemaining.set_text("Drowning ghosts remaining: " + str(GameState.number_of_ghosts))
	
	if GameState.player_health <= 0:
		bad_ending()
		
func startDialogue():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	var dialog = Dialogic.start("level5Opening")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
		
func good_ending():
	print("GOOD")
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/good_ending.tscn")

func bad_ending():
	print("BAD")
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/bad_ending.tscn")
	
func _on_area_2d_body_entered(body):
	if body is AbstractPlayer:
		if GameState.number_of_ghosts <= 0:
			good_ending()
		else:
			bad_ending()	

func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false



func _on_bad_end_dialogue_body_entered(body):
	if body is AbstractPlayer:
		if GameState.number_of_ghosts > 0:
			Dialogic.signal_event.connect(_on_dialogic_signal)
			var dialog = Dialogic.start("BadEndingBefore")
			dialog.process_mode= Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			get_tree().paused = true
		else:
			pass
