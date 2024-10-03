extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player
onready var player_controler_joystick = $YSort/Player/Controller/joystick
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_cellar_night.tscn"
var starting_player_position = Vector2  (152, 139)

onready var wine_mission = $YSort/wine_mission
onready var orig_mageguild = $mageGuild_1stFloor_night/CollisionShape2D
onready var path_arrow = $YSort/YSort/path_arrow

onready var path_to_mageguild_day = $mageGuild_1stFloor/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Cellar"
	resume.connect("pressed", self, "resume_the_game")
	wine_mission.connect("start_dialogue", self, "start_dialogue_valen")
	wine_mission.connect("end_dialogue", self, "end_dialogue_valen")
	Global.set_map(current_map)
	path_checking()
	

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("cellar 1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("cellar 2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			print("Player position set from ", target_node_path)
			print(Global.get_player_current_position())
		else:
			pass
			print("Player position set from ", target_node_path)
	elif Global2.is_badge_complete("badge14"):
		player.global_position = starting_player_position
		print("cellar badge14")
	elif int(Dialogic.get_variable("cultist_mission"))==1:
		player.global_position = starting_player_position
		print("cellar badge14")
	else:
		player.global_position = Global.get_player_current_position()
		print("cellar 3")

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

func path_checking():
	if Global2.is_badge_complete("badge13"):
		orig_mageguild.disabled = true
		path_to_mageguild_day.disabled = true
		path_arrow.hide()
	elif Global.from_level == "mageGuild_1stFloor":
		orig_mageguild.disabled = true
		path_to_mageguild_day.disabled = false
		print("trigger day guild")
	elif Global.from_level == "mageGuild_1stFloor_night":
		orig_mageguild.disabled = false
		path_to_mageguild_day.disabled = true
		print("trigger night guild")
	else:
		print(Global.from_level)
		print("trigger else")
		orig_mageguild.disabled =false
		path_to_mageguild_day.disabled = true
		path_arrow.show()
################# wine mission #############################

func start_dialogue_valen():
	player_controller.hide()
	player_controler_joystick.disable_joystick()

func end_dialogue_valen():
	player_controller.show()
	player_controler_joystick.enable_joystick()

func _on_into_maguild_day_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	SceneTransition.change_scene("res://levels/mageGuild_1stFloor.tscn")
