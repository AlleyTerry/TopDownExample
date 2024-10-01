extends Node2D

const CIGARETTE_LIGHT_ENERGY = 1
const CIGARETTE_MAX_VALUE = 15
const CIGARETTE_EXTINGUISH_STEP_PER_SECOND = 1

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer
@onready var CigaretteLight : PointLight2D = $PlatformPlayer/CigaretteLight
@onready var CigaretteTimer : Timer = $CigaretteTimer
@onready var CigaretteSprite : AnimatedSprite2D = $UICanvasLayer/UI/Cigarrete

func _ready():
	AudioPlayer.play_level_one_scene()
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fadeOut")
	await get_tree().create_timer(0.4).timeout
	
	CigaretteLight.texture_scale = CIGARETTE_MAX_VALUE
	CigaretteLight.energy = CIGARETTE_LIGHT_ENERGY
	
	CigaretteSprite.play()
	CigaretteTimer.start()
	
func _on_area_2d_body_entered(body):
	if body is AbstractPlayer:
		get_tree().change_scene_to_file("res://Scenes/level_1_denial.tscn")

func _on_cigarette_timer_timeout():
	if (CigaretteLight.texture_scale > 3) :
		CigaretteLight.texture_scale -= CIGARETTE_EXTINGUISH_STEP_PER_SECOND
		CigaretteLight.energy -= (CIGARETTE_EXTINGUISH_STEP_PER_SECOND / 20)

func _on_area_2d_2_body_entered(body):
	if body is AbstractPlayer:
		CigaretteLight.texture_scale = CIGARETTE_MAX_VALUE
		CigaretteLight.energy = CIGARETTE_LIGHT_ENERGY
		CigaretteSprite.frame = 0
		CigaretteSprite.play()

func _on_end_level_body_entered(body):
	if body is AbstractPlayer:
		GameState.moveToBedroom(SceneTransitionAnimation)

func _on_level_1_item_area_body_entered(body):
	if body is AbstractPlayer:
		$Level1Item.visible = false
		GameState.itemOneObtained = true
