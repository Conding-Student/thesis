extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var player_controller_joystick =  $YSort/Player/Controller/joystick
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player

var current_map = "res://World/room/orphanage_room.tscn"
var staring_player_position = Vector2(40,40)

# Called when the node enters the scene tree for the first time.
func _ready():
	resume.connect("pressed", self, "resume_the_game")
	set_player_position()
	
	Global.set_player_initial_position(Global.get_player_current_position())
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/orphanageDay.wav")
	Musicmanager.change_scene("orphanage")
	
	

func after_dialog(timelinename):
	player_controller.show()
	player_controller_joystick.enable_joystick()
	Global.start_level_trigger = true
	Musicmanager.normal_volume()

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0,0):
		Global.set_player_current_position(staring_player_position)
		#print("one")
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		topui.hide()
		var new_dialog = Dialogic.start('tutorial')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "after_dialog")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
	elif Global.from_level != null:
		# Construct the dynamic node path
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.position = target_node.position
		else:
			pass
			#print("Node with name '%s' does not exist" % target_node_path)
			#print(Global.from_level)
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
