extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controller_joystick = $objects/Player/Controller/joystick
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_1stFloor_night_level3.tscn"
var starting_player_position = Vector2 (244, 371)
onready var collision_quiz = $Area2D/CollisionShape2D
onready var path_to_sewer = $cellar/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	check_collision_quiz()
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Mage Guild Inside"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	Musicmanager.change_scene("Mage Guild inside")
	

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global2.is_badge_complete("badge13") && Global2.is_badge_complete("badge14") == false:
		Global.load_game_position = false
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		player.global_position = starting_player_position
		var new_dialog = Dialogic.start('level3s3p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint") 
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
		print("3")
func interaction_endpoint(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

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

func check_collision_quiz():
	if Global2.is_badge_complete("badge13") && Global2.is_badge_complete("badge14") == false:
		collision_quiz.disabled = false
		path_to_sewer.disabled = true
	else:
		collision_quiz.disabled = true
		path_to_sewer.disabled = false

func _on_Area2D_body_shape_entered_quiz(body_rid, body, body_shape_index, local_shape_index):
	var new_dialog = Dialogic.start('level3s3p3')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint_quiz")

func interaction_endpoint_quiz(timelineend):
	Global2.set_question(0, "Complete the right way to declare a variable.")
	Global2.set_answers(0, "String")
	Global2.set_answers(1, "Float ")
	Global2.set_answers(2, "Int")
	Global2.set_answers(3, "Double")
	Global2.set_feedback(0, "Incorrect. String is for text, not whole numbers.")
	Global2.set_feedback(1, "Incorrect. Float is for decimal numbers, not integers.")
	Global2.set_feedback(2, "Correct! Int is used for storing whole numbers.")
	Global2.set_feedback(3, "Incorrect. Double is for decimal numbers, not integers.")
	Global2.correct_answer_ch1_3 = true
	#2nd question
	Global2.set_question(1, "Complete the right way to declare a variable.")
	Global2.set_answers(4, "Int")
	Global2.set_answers(5, "Double ")
	Global2.set_answers(6, "Char")
	Global2.set_answers(7, "Float")
	Global2.set_feedback(4,"IIncorrect. Int is for whole numbers, not decimal values.")
	Global2.set_feedback(5,"Incorrect. Double is for more precise decimal numbers, but the 'f' suffix indicates a float.")
	Global2.set_feedback(6,"Incorrect. Char is used to store a single character.")
	Global2.set_feedback(7,"Correct! The 'f' suffix specifies that this is a float value.")
	Global2.correct_answer_ch2_4 = true
	#3rd question
	Global2.set_question(2, "Complete the right way to declare a variable.")
	Global2.set_answers(8, "Char ")
	Global2.set_answers(9, "Bool")
	Global2.set_answers(10, "Float")
	Global2.set_answers(11, "String")
	Global2.set_feedback(8,"Incorrect. Char is for storing single characters, not boolean values.")
	Global2.set_feedback(9,"Correct! Bool is used to store true or false values.")
	Global2.set_feedback(10,"Incorrect. Float is for decimal numbers, not boolean values.")
	Global2.set_feedback(11,"Incorrect. String is used for text, not boolean values.")
	Global2.correct_answer_ch3_2 = true
	
	Global.load_game_position = true
	Global2.dialogue_name = "level3s4badge14" #need to change
	SceneTransition.change_scene("res://intro/question_panel.tscn")


func _on_cellar_body_shape_entered_cellar(body_rid, body, body_shape_index, local_shape_index):
	SceneTransition.change_scene("res://levels/stage_3_night/mageGuild_cellar_night.tscn")
