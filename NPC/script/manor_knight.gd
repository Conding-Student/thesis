extends KinematicBody2D

onready var dialogue_button = $TextureButton
onready var arrow_head = $arrow_head
# Called when the node enters the scene tree for the first time.

func _ready():
	if Global2.is_badge_complete("badge1"):
		arrow_head.show()

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global2.is_badge_complete("badge1"):
		dialogue_button.visible = true
		arrow_head.hide()
	else:
		dialogue_button.visible = false
		arrow_head.hide()

func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if Global2.is_badge_complete("badge1"):
		dialogue_button.visible = false
		arrow_head.show()
	else:
		dialogue_button.visible = false
		arrow_head.show()
	
