extends Area2D

export var door_id: String = ""  # Unique ID for each bat
onready var collision = $CollisionShape2D


func _on_night_level_entrance_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.from_level = get_parent().name
	SceneTransition.change_scene("res://levels/stage_3_night/"+self.name+".tscn")
