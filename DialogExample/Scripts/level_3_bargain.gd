extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _ready():
	AudioPlayer.play_level_three_scene()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_end_body_entered(body):
	if body is AbstractPlayer:
		GameState.moveToBedroom(SceneTransitionAnimation)


func _on_level_3_item_area_body_entered(body):
	if body is AbstractPlayer:
		$Level3Item.visible = false
		GameState.itemThreeObtained = true

func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false
