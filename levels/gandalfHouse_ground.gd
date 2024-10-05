extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var gandalf = $YSort/Gandalf
onready var eating_interaction_button = $YSort/eat/Area2D/TextureButton
var current_map = "res://levels/Chapter2_maps/forest1Chap2.tscn"
var starting_player_position = Vector2   (80, 208)



# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Gandalf house"
	resume.connect("pressed", self, "resume_the_game")
	eating_interaction_button.connect("pressed",self, "eating")
	gandalf.connect("start_dialogue",self, "Hide_controller")
	gandalf.connect("end_dialogue", self, "show_controller")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif int(Dialogic.get_variable("gandalf")) == 1:
		player.global_position = starting_player_position
		first_interaction()
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
			#print("Player position set from ", target_node_path)
	else:
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())


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

func Hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_controller():
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()
############## interactions ################
func first_interaction():
	Hide_controller()
	var new_dialog = Dialogic.start('c2level1p3')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func end_intructions(timelineend):
	show_controller()
################### eating ##############################
func eating():
	Hide_controller()
	eating_interaction_button.hide()
	var new_dialog = Dialogic.start('eating')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")
	new_dialog.connect("dialogic_signal", self, "value_activating")

func value_activating(param):
	if param == "eat_food":
		PlayerStats.health = 5
	else:
		print("error in emitting signal instruction")
################### eating ##############################

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	eating_interaction_button.show()

func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	eating_interaction_button.hide()
