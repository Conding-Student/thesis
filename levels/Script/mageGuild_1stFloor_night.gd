extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_1stFloor_night.tscn"
var starting_player_position = Vector2 (568, 428)

#captain values
#onready var captain_interaction_button = $objects/people/captain/TextureButton


#cultist values
onready var cultist_sprite = $objects/people/cultist
onready var cultist_interaction_button = $objects/people/cultist/TextureButton
onready var cultist_arrow_head = $objects/people/cultist/arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Inside"
	resume.connect("pressed", self, "resume_the_game")
	#captain_interaction_button.connect("pressed",self, "captain_interaction")
	cultist_interaction_button.connect("pressed", self, "cultist_interaction")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	Musicmanager.change_scene("Mage Guild inside")
	

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

#common endpoint
func interaction_endpoint(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

########## captain section ####################
#func captain_interaction():
	#captain_interaction_button.hide()
	#player_controller.hide()
	#player_controller_joystick.disable_joystick()
	#var new_dialog = Dialogic.start('pirate')
	#add_child(new_dialog)
	#new_dialog.connect("timeline_end", self, "interaction_endpoint")
	
########## captain section ####################
########## cultist section ####################

func area_collision_cultist_entered(body_rid, body, body_shape_index, local_shape_index):
	if 1 == int(Dialogic.get_variable("introduction")) or 2 == int(Dialogic.get_variable("introduction")):
		cultist_interaction_button.show()
		cultist_arrow_head.hide()
	else:
		cultist_interaction_button.hide()
		cultist_arrow_head.show()

func area_collision_cultist_exited(body_rid, body, body_shape_index, local_shape_index):
	cultist_interaction_button.hide()
	cultist_arrow_head.show()

func cultist_interaction():
	cultist_interaction_button.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	var new_dialog = Dialogic.start('cultist')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")
	new_dialog.connect("dialogic_signal", self, "heart_replenish")

func heart_replenish(param):
	if param == "heal":
		PlayerStats.health = 5
	else:
		print("wrong value")
