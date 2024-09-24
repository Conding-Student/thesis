extends Node

onready var video_player = $VideoPlayer

func _ready():
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(2), "timeout")
	var new_dialog = Dialogic.start('inprison')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")

func interaction_endpoint(timelineend):
	pass
	
func _on_VideoPlayer_finished():
	video_player.play()
	

func _on_Skip_button_pressed():
	SceneTransition.change_scene("res://Scenes/imprison.tscn")
	
