extends Area2D


func _on_battle_mode_body_entered(body):
	Global.set_player_current_position(body.position) 
	#print("position")
	#print(body.position)
	Global.bat1_position_engaged = Global.get_enemy_current_position("enemy1")
	#print(Global.bat1_position_engaged)
	Global.player_position_retain = true
	call_deferred("change_scene", "res://Battlescenes/battle_scene_forest.tscn")

func change_scene(scene_path: String):
	get_tree().change_scene(scene_path)

