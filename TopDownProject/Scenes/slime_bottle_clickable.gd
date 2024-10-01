extends StaticBody2D


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		Global.player_bottle_array.append("SlimeBottle")
