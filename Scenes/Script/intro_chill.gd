extends Node

onready var video_player = $VideoPlayer
onready var reverse = $reverse

func _ready():
	var new_dialog = Dialogic.start('introductionp1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")

func interaction_endpoint(timelineend):
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(1), "timeout")
	video_player.play()
	var new_dialog = Dialogic.start('introduction')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint2")

func interaction_endpoint2(timelineend):
	SceneTransition.change_scene("res://intro/pre_test.tscn")

func _on_VideoPlayer_finished():
	reverse.play()



func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://levels/stage_3_night/manor_out_night.tscn")


func _on_reverse_finished():
	video_player.play()
