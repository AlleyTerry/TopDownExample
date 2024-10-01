extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _ready():
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	startDialogue()
	
func startDialogue():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	var dialog = Dialogic.start("BadEnding")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false
		SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
		SceneTransitionAnimation.play("fadeOut")
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
