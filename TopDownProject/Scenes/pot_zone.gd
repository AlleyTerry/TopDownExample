extends StaticBody2D

var bottle = Global.BottleSelected

var bottleCooking = false

var mixtureCooked = false

func _physics_process(delta):
	if bottleCooking == false:
		bottle = Global.BottleSelected
#constantly checking to make sure nothing overwrites the side

#if there's no bottle already cooking
#then check which bottle is selected
#set cooking to true, start the timer, play the animation
func _on_area_2d_area_entered(area):
	if not bottleCooking:
		if bottle == 1 && Global.GoopNumber >= 1:
			bottleCooking = true
			$GoopTimer.start()
			$Mixture.play("GoopCooking")
		if bottle == 2 && Global.SlimeNumber >= 1:
			bottleCooking = true
			$SlimeTimer.start()
			$Mixture.play("SlimeCooking")
		if bottle == 3 && Global.MilkNumber >= 1:
			bottleCooking = true
			$MilkTimer.start()
			$Mixture.play("MilkCooking")
		else:
			print("plant is already growing here")


func _on_goop_timer_timeout():
	var goopMixture = $Mixture
	if goopMixture.frame == 0:
		goopMixture.frame = 1
		$GoopTimer.start()
	elif goopMixture.frame == 1:
		goopMixture.frame = 2
		mixtureCooked = true


func _on_slime_timer_timeout():
	var slimeMixture = $Mixture
	if slimeMixture.frame == 0:
		slimeMixture.frame = 1
		$SlimeTimer.start()
	elif slimeMixture.frame == 1:
		slimeMixture.frame = 2
		mixtureCooked = true


func _on_milk_timer_timeout():
	var milkMixture = $Mixture
	if milkMixture.frame == 0:
		milkMixture.frame = 1
		$MilkTimer.start()
	elif milkMixture.frame == 1:
		milkMixture.frame = 2
		mixtureCooked = true

#if mixture is ready you can click it and move it somehwere
#in future we want it to go to a bottle to be used later
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		print("I have been clicked")
		if mixtureCooked:
			if bottle == 1:
				Global.CookedGoopNumber += 1
				Global.GoopNumber -= 1
				bottleCooking = false
				mixtureCooked = false
				$Mixture.play("NoneInPot")
				print("you have clicked did it disappear??")
			if bottle == 2:
				Global.CookedSlimeNumber += 1
				Global.SlimeNumber -= 1
				bottleCooking = false
				mixtureCooked = false
				$Mixture.play("NoneInPot")
				print("you have clicked did it disappear??")
			if bottle == 3:
				Global.CookedMilkNumber += 1
				Global.MilkNumber -= 1
				bottleCooking = false
				mixtureCooked = false
				$Mixture.play("NoneInPot")
				print("you have clicked did it disappear??")
			else:
				pass
	


