extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_control_collision = $YSort/Player/Controller/joystick
onready var interaction_button = $YSort/YSort2/Path2D/PathFollow2D/Merrick/TextureButton 
onready var place_name = $TopUi/Label2

var current_map = "res://World/room/orphanage_basement.tscn"
var starting_player_position = Vector2(236, 81)

# Path by Merrick
var t := 0.0
var path_length := 0.0
var locked = false # Triggering after conversation
var chest_unlocked = false # Track if chest has been unlocked
onready var chest = $YSort/YSort2/chest_lock/AnimatedSprite
onready var merrick_sprite = $YSort/YSort2/Path2D/PathFollow2D/Merrick/Sprite 
onready var pathfollow = $YSort/YSort2/Path2D/PathFollow2D
onready var animation_merrick = $YSort/YSort2/Path2D/PathFollow2D/Merrick/AnimationPlayer 

# Disconneting signal merrick
onready var enter_signal1 = $YSort/YSort2/Path2D/PathFollow2D/Merrick/Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Orphanage Basement"
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed", self, "merrick1")
	Global.set_map(current_map)
	# Get the length of the Path2D curve
	path_length = $YSort/YSort2/Path2D.curve.get_baked_length()
	
	if Global2.is_badge_complete("badge1") == true:
		merrick_sprite.visible = false
	

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
	
	elif Global.from_level != null and Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
		else:
			pass
	else:
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _process(delta):
	if locked:
		unlocking_chest(delta)
	
	

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

func merrick1():
	player_controller.visible = false
	player_control_collision.disable_joystick()
	interaction_button.visible = false
	var new_dialog = Dialogic.start('stage1') #new dialogue
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_stage1")

func after_stage1(timelinename):
	locked = true

func unlocking_chest(delta):
	t += delta
	merrick_sprite.flip_h = true
	pathfollow.offset = t * 50.0

	# Calculate the unit offset
	var unit_offset = pathfollow.offset / path_length

	# Play animation based on the unit offset
	if unit_offset >= 1.0:
		animation_merrick.play("finish")
		merrick_sprite.flip_h = false
		if not chest_unlocked:
			chest_unlocked = true
			chest.frame = 1
			# Trigger the second dialogue after unlocking the chest
			start_second_dialogue() # Call this method to start the second dialogue
	else:
		animation_merrick.play("walk_left")

func start_second_dialogue():
	if chest_unlocked: # Ensure the chest is unlocked before starting the dialogue
		var new_dialog1 = Dialogic.start('stagem2')
		add_child(new_dialog1)
		new_dialog1.connect("timeline_end", self, "after_stagem2")

func after_stagem2(timelinename):
	merrick_sprite.flip_h = true
	merrick_sprite.flip_h = false
	player_controller.visible = true
	player_control_collision.enable_joystick()
	Global2.complete_badge("badge1")
	merrick_sprite.visible = true
	SceneTransition.change_scene("res://intro/stages_complete.tscn")
	
