extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player =$objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var interaction_button1 = $objects/people/knight/TextureButton
onready var place_name = $TopUi/Label2

var current_map = "res://levels/manor_out.tscn"
var starting_player_position = Vector2 (528, 395)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	interaction_button1.connect("pressed", self, "knight_dialogue")
	Global.set_map(current_map)
	place_name.text = "Manor Outside"
	Musicmanager.set_music_path("res://Music and Sounds/bg music/manorOutside_day.wav"
	)
	Musicmanager.change_scene("Manor Outside")

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

func knight_dialogue():
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	Musicmanager.set_to_low()
	interaction_button1.hide()
	var new_dialog = Dialogic.start('manor_guard')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_knight")

func after_knight(timelinename):
	player_controller.visible = true
	player_controller_joystick.enable_joystick()
	Musicmanager.normal_volume()
	interaction_button1.show()
	#Global2.explore_town = int(Dialogic.get_variable("explore_town"))
	#Global2.manor_guard = int(Dialogic.get_variable("manor_guard"))


