extends Node

var target_scene_path = "res://intro/Main_menu.tscn"


func _on_VideoPlayer_finished():
	SceneRandomizer.load_random_loading_screen(target_scene_path)
