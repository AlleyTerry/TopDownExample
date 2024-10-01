extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer
var scene = preload("res://Scenes/bed.tscn")
var instance = scene.instantiate()
var rng = RandomNumberGenerator.new()

func _ready():
	AudioPlayer.play_level_four_scene()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	startDialogue()
	$Timer.start()

func startDialogue():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("Playertimeline")
	var dialog = Dialogic.start("level4Opening")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false

func _on_timer_timeout():
	print("timer ended")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("Playertimeline")
	var dialog = Dialogic.start("bedtime")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	add_child(instance)

