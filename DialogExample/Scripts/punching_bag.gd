extends Node2D

@onready var joint : PinJoint2D = get_node("Joint");

@export var health : int = 5
@export var bagNumber = 0
@export var numHits = 0


var destroyed = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func startDialoge():
	var dialog = Dialogic.start("level2Opening")
	dialog.process_mode= Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true


func _on_dialogic_signal(argument):
	if argument == "end":
		get_tree().paused = false
		
func remove_health():
	if (!destroyed && health == 1) : 
		joint.queue_free()
		destroyed = true;
		numHits= 0
	elif (!destroyed):
		health -= 1
		if bagNumber == 1:
			Dialogic.VAR.numHits = numHits
			var dialog = Dialogic.start("bag1")
			dialog.process_mode= Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			#get_tree().paused = true
			numHits +=1
		if bagNumber == 2:
			Dialogic.VAR.numHits = numHits
			var dialog = Dialogic.start("bag2")
			dialog.process_mode= Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			#get_tree().paused = true
			numHits +=1
		if bagNumber == 3:
			Dialogic.VAR.numHits = numHits
			var dialog = Dialogic.start("bag3")
			dialog.process_mode= Node.PROCESS_MODE_ALWAYS
			Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
			#get_tree().paused = true
			numHits +=1
		
