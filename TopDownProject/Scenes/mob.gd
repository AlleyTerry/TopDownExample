extends CharacterBody2D

var current_state = IDLE

var is_idle = true
var is_chatting = false 

@onready var player = get_node("/root/GameLevel/PlayerRabbit")
@export var mob_speed = 0.0
var player_in_chat_zone = false
enum {
	IDLE
}


var goop_number  = 0
var slime_number = 0
var milk_number = 0

#RandomNumberGenerator is a class for generating pseudo-random numbers
var rng = RandomNumberGenerator.new()



	
func choose_bottles():
	goop_number = rng.randi_range(0,3)
	slime_number = rng.randi_range(0,3)
	milk_number = rng.randi_range(0,3)

#we want the mob to always (for now) be headed towards the player
func _process(delta):
	#takes the global position of the mob (global position)
	#direction_to calcualtes the direction to a point
	#var direction = global_position.direction_to(player.global_position)
	#velocity = direction * mob_speed
	#move_and_slide()
	if Input.is_action_just_pressed("chat"):
		print("chatting with mob")
		$hoverText.visible = false
		$Chatbox.start()
		is_idle = false
		is_chatting = true
		


func _on_timer_2_timeout():
	$Baby.play_angry()


func _on_chatbox_dialogue_finished():
	is_chatting = false
	is_idle = true
	choose_bottles()
	print(goop_number, slime_number, milk_number)
	$BottleIcons/NinePatchRect/goopNumber.text = str(goop_number)
	$BottleIcons/NinePatchRect/milkNumber.text = str(milk_number)
	$BottleIcons/NinePatchRect/slimeNumber.text = str(slime_number)
	$BottleIcons/NinePatchRect.visible = true

func check_numbers():
	if Global.CookedGoopNumber >= goop_number:
		if Global.CookedMilkNumber >= milk_number:
			if Global.CookedSlimeNumber >= slime_number:
				print("yay i have been fed")
	else:
		print("not enough!")


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true



func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = false



func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		print("I have been clicked")
		check_numbers()
