extends Node

onready var video_player = $VideoPlayer

func _ready():
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(2), "timeout")
	var new_dialog = Dialogic.start('horseride')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")
	new_dialog.connect("dialogic_signal", self, "signal_scene")
	
func signal_scene(param):
	if param == "video_stop":
		video_player.stop()
	else:
		print("error at horseride video scene")

func interaction_endpoint(timelineend):
	pass
	
func _on_VideoPlayer_finished():
	video_player.play()
	

func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://Scenes/imprison.tscn")
	
