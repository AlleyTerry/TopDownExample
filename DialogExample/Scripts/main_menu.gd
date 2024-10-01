extends Control

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _on_start_button_pressed():
	GameState.resetGameState()
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/opening.tscn")
