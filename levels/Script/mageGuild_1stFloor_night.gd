extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var pirate_crew_interaction_button = $objects/people/piratecrew/TextureButton
#onready var captain_interaction_button = $objects/people/captain/TextureButton
onready var bard= $objects/people/bard
onready var pirate_captain = $objects/people/captain
onready var cultist = $objects/people/cultist
onready var mission_chest = $objects/objects/mission_chest
var current_map = "res://levels/stage_3_night/mageGuild_1stFloor_night.tscn"
var starting_player_position = Vector2 (568, 428)

#path to cellar


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Inside night"
	resume.connect("pressed", self, "resume_the_game")
	pirate_crew_interaction_button.connect("pressed",self, "pirate_crew_interaction")
	#captain_interaction_button.connect("pressed",self,"captain_interaction")
	#bard_interaction_button.connect("pressed", self, "bard_interaction")
	pirate_captain.connect("start_conversation",self, "conversation_start")
	pirate_captain.connect("end_conversation", self, "conversation_end")
	bard.connect("start_conversation",self, "conversation_start")
	bard.connect("end_conversation",self, "conversation_end")
	cultist.connect("start_conversation",self, "conversation_start")
	cultist.connect("end_conversation",self, "conversation_end")
	bard.connect("mission1_accepted",mission_chest, "chest_mission_available")
	mission_chest.connect("chest_has_been_opened", self, "mission_completed")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	Musicmanager.change_scene("mageguild night inside")
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
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
	else:
		player.global_position = Global.get_player_current_position()
		#print("3")

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

#bard mission 
func mission_completed():
	conversation_start()
	bard.mission_completed()

func conversation_start():
	#print("signal is okay")
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	topui.visible = false

func conversation_end():
	player_controller.show()
	player_controller_joystick.enable_joystick()
	topui.visible = true

func pirate_crew_interaction():
	print("active")

func interaction_end(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

func into_cellar(body_rid, body, body_shape_index, local_shape_index):
	if int(Dialogic.get_variable("cultist_mission")) == 1:
		Global.from_level = "mageGuild_cellar_night"
		SceneTransition.change_scene("res://levels/stage_3_night/mageGuild_cellar_night.tscn")
	else:
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('cellar_lock')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_end")
