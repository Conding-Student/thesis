extends CanvasLayer


func change_scene(target: String) -> void:
	$"/root/SceneTransition".visible = true
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	
	$AnimationPlayer.play_backwards("dissolve")
	$"/root/SceneTransition".visible = false
