extends KinematicBody2D

onready var merrick = $Sprite
onready var dialogue_button = $TextureButton
# $TextureButtonCalled when the node enters the scene tree for the first time.
func _ready():
	if Global2.badge1 == true:
		merrick.visible = true
		#print(Global.stage1)
	else:
		merrick.visible = false

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if Global2.badge1 == true:
		dialogue_button.visible = true
		Global.player_position_retain = false
		Global.set_player_current_position(body.position)

	else:
		dialogue_button.visible = false

func _on_Area2D_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	dialogue_button.visible = false
	Global.player_position_retain = false
	#print(Global.player_position_retain)
	
