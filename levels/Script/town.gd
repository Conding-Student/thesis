extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controller_joystick = $YSort/Player/Controller/joystick
onready var interaction_button1 = $YSort/people/citizen3/TextureButton
onready var place_name = $TopUi/Label2
var current_map = "res://levels/towncenter.tscn"
var starting_player_position = Vector2(128, 67)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	interaction_button1.connect("pressed", self, "citizen_dialogue")
	place_name.text = "Towncenter"
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

func citizen_dialogue():
	interaction_button1.hide()
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	Musicmanager.set_to_low()
	var new_dialog = Dialogic.start('citizen3')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_citizen3")
	

func after_citizen3(timelinename):
	interaction_button1.show()
	player_controller.visible = true
	player_controller_joystick.enable_joystick()
	Musicmanager.normal_volume()
	Global2.explore_town = int(Dialogic.get_variable("explore_town"))
	Global2.lady_on_townsquare = int(Dialogic.get_variable("citizen"))


