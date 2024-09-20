extends KinematicBody2D

onready var dialogue_button = $TextureButton

func _ready():
	dialogue_button.visible = false

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global2.is_badge_complete("badge1") == false:
		dialogue_button.visible = true
		#print(Global.stage1)
	else:
		dialogue_button.visible = false

func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	dialogue_button.visible = false

