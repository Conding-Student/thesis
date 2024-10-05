extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var book = $Floating_book
var current_map = "res://levels/stage_3_night/mageGuild_secretLibrary.tscn"
var starting_player_position = Vector2 (568, 428)


# Called when the node enters the scene tree for the first time.
func _ready():
	book.connect("start_interaction", self, "controller_hide")
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Secret Library"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/libary.wav")
	Musicmanager.change_scene("Secret_library")
	if Global2.is_badge_complete("badge15"):
		Musicmanager.stop_music()
		SceneTransition.change_scene("res://Scenes/timetravel.tscn")
	else:
		print("error in loading movie scene onging chapter2")

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("cellar 1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("cellar 2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
			#print(Global.get_player_current_position())
		else:
			pass
			#print("Player position set from ", target_node_path)
	#elif Global2.is_badge_complete("badge14") == false:
		#player.global_position = starting_player_position
	else:
		player.global_position = Global.get_player_current_position()
		#print("cellar 3")

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

func controller_hide():
	player_controller.hide()
	topui.hide()
