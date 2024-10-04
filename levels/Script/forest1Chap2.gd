extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var gandalf = $YSort/Gandalf
var current_map = "res://levels/Chapter2_maps/forest1Chap2.tscn"
var starting_player_position = Vector2  (36, 52)



# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Old Syntaxia forest"
	resume.connect("pressed", self, "resume_the_game")
	gandalf.connect("start_dialogue", self, "hide_controller")
	gandalf.connect("end_dialogue", self, "show_instruction")
	checking_gandalf_appearance()
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global2.is_badge_complete("badge15") && int(Dialogic.get_variable("gandalf")) == 0:
		print("dialogue trigger")
		introduction()
		player.global_position = starting_player_position
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
		else:
			pass
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

############## interactions ################
func hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_instruction():
	hide_controller()
	gandalf.queue_free()
	var new_dialog = Dialogic.start('finding_house')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func introduction():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	var new_dialog = Dialogic.start('c2level1p1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func end_intructions(timelineend):
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()

func checking_gandalf_appearance():
	if int(Dialogic.get_variable("gandalf")) != 0:
		gandalf.queue_free()
	else:
		pass
		#print("gandalf alive")
