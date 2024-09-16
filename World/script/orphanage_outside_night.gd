extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
onready var place_name = $TopUi/Label2
var current_map = "res://World/room/night/orphanage_outside_night.tscn"
var starting_player_position = Vector2(128, 67)

func _ready():
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	place_name.text = "Orphanage Outside"
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
			#print(Global.from_level)
			#print("Node with name '%s' does not exist" % (Global.from_level + "_pos"))
	else:
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())
	

		
func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _process(_delta):
	pass
	#print(Global.get_bat_state())

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

