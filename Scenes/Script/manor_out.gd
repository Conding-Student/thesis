extends Node

onready var video_player = $VideoPlayer
var is_reversing = false  # To track whether the video is reversing or playing forward

func _ready():
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(1), "timeout")
	
	video_player.play()
	var new_dialog = Dialogic.start('manor_out')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")

func interaction_endpoint(timelineend):
	SceneTransition.change_scene("res://levels/stage_3_night/manor_out_night.tscn")

func _on_VideoPlayer_finished():
	video_player.play()



func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://levels/stage_3_night/manor_out_night.tscn")
