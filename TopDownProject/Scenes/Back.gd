class_name BackButton extends Button

@export var connected_scene: String #name of scene to change to in inspector

var scene_folder = "res://Scenes/"


	



func _on_button_down():
	print("I am being pressed!")
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file(full_path)
