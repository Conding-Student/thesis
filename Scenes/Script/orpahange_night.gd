extends Node

onready var video_player = $VideoPlayer

func _ready():
	Musicmanager.stop_music()
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(2), "timeout")
	#$AnimationPlayer.play("FADE OUT")
	#yield(get_tree().create_timer(2), "timeout")
	#var result = get_tree().change_scene("res://World/room/night/orphanage_room_night.tscn")
	#if result != OK:
		#print("Failed to change scene: ", result)
func _on_VideoPlayer_finished():
	#$AnimationPlayer.play("FADE OUT")
	#yield(get_tree().create_timer(2), "timeout")
	#SceneTransition.change_scene("res://World/room/night/orphanage_room_night.tscn")
	SceneRandomizer.load_random_loading_screen("res://World/room/night/orphanage_room_night.tscn")
	#SceneTransition.change_scene("res://Dialogue/Cutscene_sample.tscn")
	#get_tree().change_scene("res://dialogue/introduction.tscn")

func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://World/room/night/orphanage_room_night.tscn")
	#SceneRandomizer.load_random_loading_screen("res://World/room/night/orphanage_room_night.tscn")
	#SceneTransition.change_scene("res://Dialogue/Cutscene_sample.tscn")
	#SceneTransition.change_scene("res://dialogue/introduction.tscn")
