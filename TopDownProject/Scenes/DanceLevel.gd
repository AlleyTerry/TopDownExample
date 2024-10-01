extends Node2D

var animation1 = ""
var animation2 = ""
var animation3 = ""
var anim_array = [ "SlimeBottle", "GoopBottle", "MilkBottle"]
var bottle_array = []



func _on_area_2d_input_event(viewport, event, shape_idx):

	if Input.is_action_just_pressed("click"):
		bottle_array.clear()
		Global.player_bottle_array.clear()
		$OKNO.play("nothing")
		#if you click on the bottle it will set and play this set of animations
		#the whiles check to make sure they arent equal to each other to ensure "randomness"
		print("I have been clicked")
		animation1 = anim_array.pick_random()
		bottle_array.append(animation1)
		animation2 = anim_array.pick_random()
		while animation1 == animation2:
			animation2 = anim_array.pick_random()
		
		bottle_array.append(animation2)
		animation3 = anim_array.pick_random()
		while animation3 == animation2:
			animation3 = anim_array.pick_random()
		
		bottle_array.append(animation3)
		print(bottle_array)
		$StaticBody2D/PoseAnimationPlayer.play(animation1)
		$StaticBody2D/PoseAnimationPlayer.queue(animation2)
		$StaticBody2D/PoseAnimationPlayer.queue(animation3)
		$StaticBody2D/PoseAnimationPlayer.queue("EmptyBottle")
		
		



func _on_done_button_button_down():
	var isEqual = false
	print(bottle_array)
	print(Global.player_bottle_array)
	#check if both arrays are equal
	#if they are play good animation
	#if not play bad aniamtion
	for i in bottle_array:
		for j in Global.player_bottle_array:
			if i == j:
				isEqual = true
			else:
				isEqual = false
	if (isEqual == true):
		print("big if true")
		$OKNO.play("OK")
		for i in Global.player_bottle_array:
				if i == "SlimeBottle":
					Global.SlimeNumber += 1
				elif i == "GoopBottle": 
					Global.GoopNumber += 1
				elif i == "MilkBottle":
					Global.MilkNumber += 1
		print(Global.SlimeNumber, Global.MilkNumber, Global.GoopNumber)
	else:
		print("womp womp")
		$OKNO.play("NO")
	bottle_array.clear()
	Global.player_bottle_array.clear()


