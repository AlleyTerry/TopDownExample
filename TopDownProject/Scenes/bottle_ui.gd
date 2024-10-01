extends Control



func _physics_process(delta):
	$NinePatchRect/MilkNumber.text = str(Global.MilkNumber)
	$NinePatchRect/GoopNumber.text = str(Global.GoopNumber)
	$NinePatchRect/SlimeNumber.text = str(Global.SlimeNumber)
