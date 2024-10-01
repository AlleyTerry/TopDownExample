extends Node

var currentLevel = 1

#Fast cheat cause of time pressure
var player_health = 5
var number_of_ghosts = 5

var itemOneObtained : bool = false
var itemTwoObtained : bool = false
var itemThreeObtained : bool = false
var itemFourObtained : bool = false
var itemFiveObtained : bool = false

func resetGameState():
	currentLevel = 1
	player_health = 5
	number_of_ghosts = 5
	itemOneObtained = false
	itemTwoObtained = false
	itemThreeObtained = false
	itemFourObtained = false
	itemFiveObtained = false
	
func moveToBedroom(SceneTransitionAnimation: AnimationPlayer):
	currentLevel += 1
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/bedroom_scene.tscn")
