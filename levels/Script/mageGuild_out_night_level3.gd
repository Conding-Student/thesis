extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_out_night_level3.tscn"
var starting_player_position = Vector2 (381, 298)
var dialogue

onready var collision_to_getinside = $Area2D2/CollisionShape2D
onready var quiz_collision = $Area2D/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global2.is_badge_complete("badge13") == false:
		collision_to_getinside.disabled = true
		quiz_collision.disabled = false
	else:
		collision_to_getinside.disabled = false
		quiz_collision.disabled = true
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Outside"
	resume.connect("pressed", self, "resume_the_game")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildOutside_night.wav")
	Musicmanager.change_scene("Mage Guild Outside night")
	Global.set_map(current_map)

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			print("Player position set from ", target_node_path)
			#print(Global.get_player_current_position())
		else:
			pass
			print("Player position set from ", target_node_path)
	elif Global2.is_badge_complete("badge12") && Global2.is_badge_complete("badge13") == false:
		player.global_position = starting_player_position
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('level3s3p1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint") 
	else:
		player.global_position = Global.get_player_current_position()
		print("3")

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func interaction_endpoint(timelineend):
	Musicmanager.normal_volume()
	player_controller.show()
	player_controller_joystick.enable_joystick()

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


func _on_Area2D_body_shape_entered_unlocking(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, " C# is a strongly typed language. It means that you cannot use variables without _ _ _")
	Global2.set_answers(0, "String")
	Global2.set_answers(1, "Data types")
	Global2.set_answers(2, "Literals")
	Global2.set_answers(3, "Oxygen")
	Global2.set_feedback(0, "Incorrect. A string is a data type, but C# requires specifying the correct data type for any variable.")
	Global2.set_feedback(1, "Correct! C# is strongly typed, so variables must have a defined data type.")
	Global2.set_feedback(2, "Incorrect. Literals represent fixed values, but variables need data types.")
	Global2.set_feedback(3, "Incorrect. Oxygen is unrelated to programming languages and variables.")
	Global2.correct_answer_ch1_2 = true
	#2nd question
	Global2.set_question(1, "Which data type is used to store text of varying length in C#?")
	Global2.set_answers(4, "String")
	Global2.set_answers(5, "Int ")
	Global2.set_answers(6, "Char ")
	Global2.set_answers(7, "Float ")
	Global2.set_feedback(4,"Correct! String is used to store text of varying length.")
	Global2.set_feedback(5,"Incorrect. Int is used for storing whole numbers, not text.")
	Global2.set_feedback(6,"Incorrect. Char is used for storing a single character, not varying-length text.")
	Global2.set_feedback(7,"Incorrect. Float is used for storing numbers with decimal points, not text")
	Global2.correct_answer_ch2_1 = true
	Global2.dialogue_name = "vallevel2s2"
	#3rd question
	Global2.set_question(2, "Which data type is used to store a single character in C#?")
	Global2.set_answers(8, "Char")
	Global2.set_answers(9, "String")
	Global2.set_answers(10, "Bool")
	Global2.set_answers(11, "Double")
	Global2.set_feedback(8,"Correct! Char is used to store a single character.")
	Global2.set_feedback(9,"Incorrect. String is used for storing a sequence of characters, not just one.")
	Global2.set_feedback(10,"Incorrect. Bool is used to store true or false values, not characters.")
	Global2.set_feedback(11,"Incorrect. Bool is used to store true or false values, not characters.")
	Global2.correct_answer_ch3_1 = true
	#4th question
	Global2.set_question(3, "Which of the following is not a valid data type in C#?")
	Global2.set_answers(12, "Char")
	Global2.set_answers(13, "String")
	Global2.set_answers(14, "Bool")
	Global2.set_answers(15, "real")
	Global2.set_feedback(12,"Incorrect. Char is a valid data type for storing a single character.")
	Global2.set_feedback(13,"Incorrect. String is a valid data type for storing text.")
	Global2.set_feedback(14,"Incorrect. Bool is a valid data type for storing true or false values.")
	Global2.set_feedback(15,"Correct! Real is not a valid data type in C#. You might be thinking of float or double for real numbers.")
	Global2.correct_answer_ch4_4 = true
	#5th question
	Global2.set_question(4, "What refers to a memory address that holds space for temporary data in C#")
	Global2.set_answers(16, "Constan")
	Global2.set_answers(17, "String")
	Global2.set_answers(18, "Variable")
	Global2.set_answers(19, "Boolean")
	Global2.set_feedback(16,"Incorrect. A constant holds data that cannot change, not temporary data.")
	Global2.set_feedback(17,"Incorrect. A string is a data type for storing text, not for holding temporary data")
	Global2.set_feedback(18,"Correct! A variable refers to a memory address that holds temporary data.")
	Global2.set_feedback(19,"Incorrect. Boolean is a data type for storing true or false values, not for holding temporary data.")
	Global2.correct_answer_ch5_3 = true
	Global.load_game_position = true
	Global2.dialogue_name = "level3s3badge13"
	SceneTransition.change_scene("res://intro/question_panel.tscn")


func transport_inside(body_rid, body, body_shape_index, local_shape_index):
	SceneTransition.change_scene("res://levels/stage_3_night/mageGuild_1stFloor_night_level3.tscn")
