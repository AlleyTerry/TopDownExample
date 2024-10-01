extends Control



func _physics_process(delta):
	$NinePatchRect/milk.text = str(Global.CookedMilkNumber)
	$NinePatchRect/goop.text = str(Global.CookedGoopNumber)
	$NinePatchRect/slime.text = str(Global.CookedSlimeNumber)
