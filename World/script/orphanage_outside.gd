extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player
onready var player_controller_joystick = $YSort/Player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var interaction_button = $YSort/Area2D/TextureButton

var current_map = "res://World/room/orphanage_outside.tscn"
var starting_player_position = Vector2(128, 67)

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_button.hide()
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	place_name.text = "Orphanage Outside"
	interaction_button.connect("pressed",self, "_on_signage_interaction")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/orphanageDay.wav")
	Musicmanager.change_scene("orphanage")
	
#functionality after getting the updated dialogic
func _on_signage_interaction():
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	interaction_button.visible = false
	get_tree().paused = true
	var new_dialog = Dialogic.start('tips')
	new_dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_dialog")

func after_dialog(timelinename):
	player_controller.visible = true
	player_controller_joystick.enable_joystick()
	interaction_button.visible = true
	get_tree().paused = false
	# Remove the dialog from the scene tree
	#var dialog = get_child(get_child_count() - 1) # Assuming the dialog is the last added child
	#if dialog:
		#dialog.queue_free() # This will remove the dialog node

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

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()
	

func _on_door_markings_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_position_engaged(body.position)

func _on_door_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	SceneTransition.change_scene("res://World/room/orphanage_hallway.tscn")

#signage interaction
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.show()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.hide()
