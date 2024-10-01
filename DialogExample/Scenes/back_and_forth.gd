extends Node2D

var player_in_area = false
@export var currentDialogue = ""
var rng = RandomNumberGenerator.new()

func _ready():
	print(currentDialogue)


	
func _physics_process(delta):
	if player_in_area == true:
		if Input.is_action_just_pressed("chat_start"):
			var random_num = rng.randi_range(1,3)
			Dialogic.VAR.choreHits = random_num
			Dialogic.signal_event.connect(_on_dialogic_signal)
			##Dialogic.start("Playertimeline")
			var dialog = Dialogic.start(currentDialogue)
			dialog.process_mode= Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			get_tree().paused = true


func _on_dialogic_signal(argument: String):
	if argument == "end":
		print("ended")
		get_tree().paused = false


func _on_area_2d_body_exited(body):
		if body is AbstractPlayer:
			player_in_area = false


func _on_area_2d_body_entered(body):
	if body is AbstractPlayer:
		player_in_area = true
