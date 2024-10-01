extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _ready():
	AudioPlayer.play_level_two_scene()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	startDialogue()
	

func _on_end_body_entered(body):
	if body is AbstractPlayer:
		GameState.moveToBedroom(SceneTransitionAnimation)

func startDialogue():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("Playertimeline")
	var dialog = Dialogic.start("level2Opening")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true


func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false


func _on_level_2_item_area_body_entered(body):
	if body is AbstractPlayer:
		$Level2Item.visible = false
		GameState.itemTwoObtained = true
