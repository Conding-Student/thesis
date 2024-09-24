extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controller_joystick = $YSort/Player/Controller/joystick
onready var place_name = $TopUi/Label2

#merrick values
onready var merrick_sprite = $YSort/merick
onready var merrick_collision_area = $YSort/merick/Area2D/CollisionShape2D
onready var interacton_button = $YSort/merick/TextureButton

var current_map = "res://World/room/night/orphanage_basement_night.tscn"
var starting_player_position = Vector2(236, 81)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	interacton_button.connect("pressed",self, "merrick_interaction")
	Global.set_map(current_map)
	place_name.text = "Orphanage Basement"
	#this one can be remove
	#condition for merrick to be able to spawn
	if Global2.is_badge_complete("badge5"):
		merrick_sprite.show()
	else:
		merrick_sprite.hide()

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null and Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			print("3")
		else:
			print("position")
	else:
		if Global.map == "res://World/room/night/orphanage_basement_night.tscn":
			player.global_position = Global.get_player_current_position()
		else:
			print("4")

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _process(delta):
	Global.set_player_current_position(player.global_position)

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

func merrick_interaction():
	interacton_button.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	if 0 == int(Dialogic.get_variable("introduction")):
		
		var new_dialog = Dialogic.start('before_level2s1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint")
	else:
		var new_dialog = Dialogic.start('ongoing_level2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint")
		new_dialog.connect("dialogic_signal", self, "s2s1_done")

func s2s1_done(param):
	if param == "s2s1_done":
		Global2.complete_badge("badge6")
		SceneTransition.change_scene("res://intro/stages_complete.tscn")

func interaction_endpoint(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

# When player near at merrick this will happen
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	interacton_button.show()
func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	interacton_button.hide()
