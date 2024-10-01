extends Control

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _ready():
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	Dialogic.start("opening")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func _on_dialogic_signal(argument):
	if argument == "openingEnd":
		SceneTransitionAnimation.play("fadeIn")
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/bedroom_scene.tscn")
