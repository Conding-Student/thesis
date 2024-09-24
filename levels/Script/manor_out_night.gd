extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player =$objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var interaction_button = $objects/Merrick_manor/TextureButton
onready var attack_button = $objects/Player/Controller/Control/BtnAttack
onready var path_inside_manor = $manor_inside_night/CollisionShape2D
onready var question_before_entering = $Area2D/CollisionShape2D
var current_map = "res://levels/stage_3_night/manor_out_night.tscn"
var starting_player_position = Vector2 (528, 395)
var door_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	question_before_entering.disabled = true
	set_overall_initial_position()
	set_player_position()
	player_controller_joystick.enable_joystick()
	Musicmanager.normal_volume()
	place_name.text = "Manor outside"
	Global.set_current_level(current_level.text)
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed", self, "merrick2")
	attack_button.hide()
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/manorOutside_night.wav")
	Musicmanager.change_scene("Manor outside")
	
	if Global.get_door_state("manor_inside"):
		#print("Bat is dead on load, removing from scene: ID =", bat_id)  # Debugging print
		path_inside_manor.disabled = false
	else:
		path_inside_manor.disabled = true
	
	#if Global.get_dialogue_state("manor_inside"):
		#print("Bat is dead on load, removing from scene: ID =", bat_id)  # Debugging print
		#question_before_entering.disabled = true
	#else:
		#question_before_entering.disabled = false
	
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

func _process(_delta):
	pass
	
func merrick2():
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	Musicmanager.set_to_low()
	interaction_button.visible = false
	var new_dialog = Dialogic.start('stage3p1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")
	new_dialog.connect("dialogic_signal", self, "merrick_inside")

func interaction_endpoint(timelineend):
	player_controller.visible = true
	player_controller_joystick.enable_joystick()
	Musicmanager.resume_music()

func merrick_inside(param):
	if param == "merrick_inside":
		$objects/Merrick_manor.hide()
		question_before_entering.disabled = false
	else:
		question_before_entering.disabled = true
	
	
func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

func unlocking(param):
	if param == "unlocking":
		player_controller.visible = true
		Global2.set_question(0,"Which of the following flowchart symbols is used to represent a process or action?")
		Global2.set_answers(0,"Oval")
		Global2.set_answers(1,"Rectangle")
		Global2.set_answers(2,"Square")
		Global2.set_answers(3,"Diamond")
		Global2.set_picture_path(0,"res://intro/picture/question/Flowchart_shape_unit1.png")
		
		Global2.set_feedback(0,"Not this one, This shape used in the beggining and endof the flowchart")
		Global2.set_feedback(1,"Correct!")
		Global2.set_feedback(2,"nope, Square shape doesn't commonly used in flowcharting.")
		Global2.set_feedback(3,"Wrong Valen!, This diamond shape is most commonly used in decision making.")

		Global2.dialogue_name = "stage3React1"
		Global2.correct_answer_ch1_2 = true
		Global.set_dialogue_state("manor_inside", true)
		Global.set_door_state("manor_inside", true)
	else:
		print("error")

func entering_manor_door(body_rid, body, body_shape_index, local_shape_index):
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	Musicmanager.set_to_low()
	
	Musicmanager.stop_music()
	var new_dialog = Dialogic.start('door_lock')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")
	new_dialog.connect("dialogic_signal", self, "unlocking")
