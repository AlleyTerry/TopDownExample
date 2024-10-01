extends PanelContainer

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
