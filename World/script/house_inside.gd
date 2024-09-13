extends Node2D


onready var topui = $TopUi
onready var player_controller = $YSort/YSort2/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/YSort2/Player
onready var current_level = $TopUi/Level



var current_map = "res://World/room/house_inside.tscn"
var staring_player_position = Vector2(40,40)

# Called when the node enters the scene tree for the first time.
func _ready():
	resume.connect("pressed", self, "resume_the_game")
	set_player_position()
	
	Global.set_player_initial_position(Global.get_player_current_position())
	Global.set_map(current_map)
	Global.set_current_level(current_level.text)

func _process(_delta):
	Global.set_player_current_position(player.global_position)

func after_dialog(timelinename):
	player_controller.show()
	Global.start_level_trigger = true

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0,0):
		Global.set_player_current_position(staring_player_position)
		#print("one")
		player_controller.hide()
		topui.hide()
		var new_dialog = Dialogic.start('tutorial')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "after_dialog")
	elif Global.get_player_initial_position() != Vector2(0,0) and Global.player_position_retain == true:
		player.global_position = Global.get_player_position_engaged()
		Global.player_position_retain = false	
		#print("two")	
	
	elif Global.get_player_after_door_position() != Vector2(0,0):
		player.global_position = Global.get_player_after_door_position()
		#print("three")
	else:
		player.global_position = Global.get_player_current_position()
		#print("five")	

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.player_position_retain = true
	Global.door_activated = true
	SceneTransition.change_scene("res://levels/World.tscn")


func door_markings(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_after_door_position(body.position)
