extends Node2D

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _on_end_body_entered(body):
	if body is AbstractPlayer:
		GameState.moveToBedroom(SceneTransitionAnimation)
		$Level4Item.visible = false
		GameState.itemFourObtained = true
		
