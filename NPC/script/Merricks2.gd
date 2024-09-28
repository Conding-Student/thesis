extends KinematicBody2D

onready var merrick = $Sprite
onready var dialogue_button = $TextureButton
onready var arrow_head = $arow_head
# $TextureButtonCalled when the node enters the scene tree for the first time.
func _ready():
	if Global2.is_badge_complete("badge1"):
		merrick.visible = true
		#print(Global.stage1)
	else:
		merrick.visible = false
		arrow_head.hide()

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if Global2.is_badge_complete("badge1"):
		dialogue_button.visible = true
		arrow_head.hide()
		Global.player_position_retain = false
		Global.set_player_current_position(body.position)
	else:
		dialogue_button.visible = false
		arrow_head.show()

func _on_Area2D_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if Global2.is_badge_complete("badge1"):
		dialogue_button.visible = false
		arrow_head.show()
		Global.player_position_retain = false
	else:
		dialogue_button.visible = false
		arrow_head.hide()
	
	#print(Global.player_position_retain)
	
