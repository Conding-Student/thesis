extends Node2D

onready var button = $TextureButton
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global2.badge2 == true:
		button.visible = true
		Global.set_player_current_position(body.position)
		Global.player_position_retain = true
		
	else:
		print(Global2.badge2)


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	button.visible = false
	Global.player_position_retain = false
