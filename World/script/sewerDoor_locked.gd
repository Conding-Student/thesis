extends Node2D

onready var path_arrow = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global2.is_badge_complete("badge13"):
		path_arrow.visible = true
		
	else:
		path_arrow.visible = false
		print("badge13 not trigger in sewer door to library")

