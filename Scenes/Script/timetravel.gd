extends Node

onready var video_player = $VideoPlayer
var is_reversing = false  # To track whether the video is reversing or playing forward

func _ready():
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(1), "timeout")
	
	video_player.play()
	var new_dialog = Dialogic.start('timetravelling')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")

func interaction_endpoint(timelineend):
	$AnimationPlayer.play("FADE OUT")
	yield(get_tree().create_timer(1), "timeout")
	SceneTransition.change_scene("res://levels/stage_3_night/mageGuild_out_night_level3.tscn")

func _on_VideoPlayer_finished():
	video_player.play()



func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://levels/stage_3_night/mageGuild_out_night_level3.tscn")
