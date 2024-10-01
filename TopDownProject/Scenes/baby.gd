extends Node2D


func wait_anim():
	%AnimationPlayer.play("idle")
	

func play_angry():
	$Fire.visible = true
	$AnimationPlayer.play("angryBaby")

func play_hurt():
	$Fire.visible = true
	$AnimationPlayer.play("BabyHurt")
	$AnimationPlayer.queue("angryBaby")




