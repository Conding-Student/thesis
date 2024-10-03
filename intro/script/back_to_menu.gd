extends Node

onready var ui = $Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	ui.hide()


func _on_Yes_pressed():
	get_tree().paused = false
	Musicmanager.stop_music()
	SceneTransition.change_scene("res://intro/Main_menu.tscn")



func _on_No_pressed():
	ui.hide()
