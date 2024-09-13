extends Node

onready var ui = $Panel

func _ready():
	ui.hide()

func _on_No_pressed():
	ui.hide()


func _on_Yes_pressed():
	get_tree().quit()
