extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var pirate_crew_interaction_button = $objects/people/piratecrew/TextureButton
onready var captain_interaction_button = $objects/people/captain/TextureButton

var current_map = "res://levels/mageGuild_1stFloor.tscn"
var starting_player_position = Vector2 (568, 428)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Inside"
	resume.connect("pressed", self, "resume_the_game")
	pirate_crew_interaction_button.connect("pressed",self, "pirate_crew_interaction")
	captain_interaction_button.connect("pressed",self,"captain_interaction")
	Global.set_map(current_map)

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
func pirate_crew_interaction():
	print("active")

func captain_interaction():
	captain_interaction_button.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	var new_dialog = Dialogic.start('pirate')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_end")

func interaction_end(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()
