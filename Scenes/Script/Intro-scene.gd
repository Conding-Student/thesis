extends Node

onready var video_player = $VideoPlayer

func _on_VideoPlayer_finished():
	SceneRandomizer.load_random_loading_screen("res://World/room/orphanage_room.tscn")
	#SceneTransition.change_scene("res://Dialogue/Cutscene_sample.tscn")
	#get_tree().change_scene("res://dialogue/introduction.tscn")

func _on_Skip_button_pressed():
	SceneRandomizer.load_random_loading_screen("res://World/room/orphanage_room.tscn")
	#SceneTransition.change_scene("res://Dialogue/Cutscene_sample.tscn")
	#SceneTransition.change_scene("res://dialogue/introduction.tscn")
