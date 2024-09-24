extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
onready var place_name = $TopUi/Label2
var current_map = "res://World/room/night/orphanage_hallway_night.tscn"
var staring_player_position = Vector2(301,102)

var starting_dialopgue = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	place_name.text = "Orphanage Hallway"
	Musicmanager.set_music_path("res://Music and Sounds/bg music/orphanageNight.wav")
	Musicmanager.change_scene("orphanage_night")
	
	
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0,0):
		Global.set_player_current_position(staring_player_position)
		#print("one")
		
		
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
		
	elif Global.from_level != null:           
		if has_node(Global.from_level + "_pos"):
			var target_node = get_node(Global.from_level + "_pos")
			player.global_position = target_node.position		
			#print("Player position set from ", Global.from_level + "_pos")
			print(Global.player_position_retain)
		else:
			pass
			#print(Global.from_level)
			#print("Node with name '%s' does not exist" % (Global.from_level + "_pos"))
	else:
		#print(Global.from_level)
		player.global_position = Global.get_player_current_position()
		#print("five")    

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func after_tutorial_headings(timelinename):
	topui.show()
	player_controller.show()
	Global.door_activated=true
	

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _process(_delta):
	Global.set_player_current_position(player.global_position)
	
func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()
