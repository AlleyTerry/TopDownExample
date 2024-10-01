extends CharacterBody2D


#parameters/Idle/blend_position
#@export makes it visible in inspector like "public" in unity
# : represents what type of variable you want it to be
@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

#@onready is when the script starts
#it is going to find an object called animationTree and store it in the variable
@onready var animation_tree = $AnimationTree
#allows us to change the state / blendspace
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

#will run a certain number of times per second
#moving and colliding you would need physics process
#delta is the time since the last thing happened
func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		#we use get action strength  and the tag "right" so that the tag can be connected to any input
		#not just hardcoded to specific inputs like the wasd keys
		#get action strength will detect how strong you pressed the input between 0 and 1 
		Input.get_action_strength("right")- Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
								)


	update_animation_parameters(input_direction)
	
	#print(input_direction)
	#update velocity
	#velocity already exists because the character body already has a velocity
	velocity = input_direction * move_speed
	
	#move and slide function uses velocity of character body to move character on map
	#if you come across a wall the character will slide across the wall instead of
	#move_collide will stop you with a full on collision
	move_and_slide()
	
	pick_new_state()
	
#function to set the animation parameter based off of the number move_input
#however if there is no input, it does nothing
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO ):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

#this function sees if the player velocity is anthing other than 0
#if its not 0 it will switch to the walk state
#otherwise it is the Idle state
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
