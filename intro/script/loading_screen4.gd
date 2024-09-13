extends Control

var target_scene = ""

func _ready():
	# Optionally initialize things here
	pass

func set_target_scene(scene):
	target_scene = scene

func _on_Timer_timeout():
	$ProgressBar.value += 0.95
	
	if $ProgressBar.value >= 50 and $Label.visible:
		$Label.visible = false
		$tip2.visible = true
	
	if $ProgressBar.value >= 100:
		# Notify SceneRandomizer to load the target scene
		if SceneRandomizer:
			SceneRandomizer.load_target_scene()
