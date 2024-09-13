extends Node2D



func _ready():
	$AnimationPlayer.play("Fadein")
	yield(get_tree().create_timer(6), "timeout")
	$AnimationPlayer.play("FADE OUT")
	yield(get_tree().create_timer(3), "timeout")
	var result = get_tree().change_scene("res://intro/icon_cutscene.tscn")
	if result != OK:
		print("Failed to change scene: ", result)
