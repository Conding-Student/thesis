extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
#onready var interaction_button = $objects/door/TextureButton
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_sewer_night.tscn"

var starting_player_position = Vector2 (568, 428)

onready var path_to_library = $mageGuild_secretLibrary/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global2.is_badge_complete("badge14"):
		path_to_library.disabled = false
	else:
		path_to_library.disabled = true
	
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	#interaction_button.connect("pressed", self, "first_door")
	Global.set_map(current_map)
	place_name.text = "Mage Guild Sewer"
	Musicmanager.set_music_path("res://Music and Sounds/bg music/sewer_library.wav")
	Musicmanager.change_scene("Mage Guild Sewer")

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
	# Whenever the player get into new scene of event.
	elif Global.get_player_current_position() != Vector2(0,0) and Global.player_position_retain == true:
		player.global_position = Global.get_player_current_position()
		
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

#accesing dialogue
func first_door():
	player_controls.visible = false
	#interaction_button.visible = false
	
	Global.set_map(current_map)
	var new_dialog = Dialogic.start('valstage5ep1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_val")

#dialogue end
func after_val(timelineend):
	pass
