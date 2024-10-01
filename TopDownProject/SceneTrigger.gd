class_name SceneTrigger extends Area2D


@export var connected_scene: String #name of scene to change to in inspector

var scene_folder = "res://Scenes/"

func _on_body_entered(body):
	print("I am being entered!")
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file(full_path)
