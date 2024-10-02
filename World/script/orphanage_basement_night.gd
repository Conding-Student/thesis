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
onready var arrow_head = $YSort/merick/talk_box

var current_map = "res://World/room/night/orphanage_basement_night.tscn"
var starting_player_position = Vector2(236, 81)
var tutorial_trigger = false
#stage3 chest
onready var woodenchest_arrow_head = $YSort/chest/Wooden_chest/arrow_head
onready var woodenchest_closed = $YSort/chest/Wooden_chest/wooden_chest_closed
onready var woodenchest_collision = $YSort/chest/Wooden_chest/wooden_chest_closed/Area2D/CollisionShape2D
onready var woodensolid_chest_collision = $YSort/chest/Wooden_chest/StaticBody2D/CollisionShape2D
onready var woodenchest_open = $YSort/chest/Wooden_chest/StaticBody2D/open
#stage4 chest


# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	interacton_button.connect("pressed",self, "merrick_interaction")
	Global.set_map(current_map)
	place_name.text = "Orphanage Basement"
	Musicmanager.set_music_path("res://Music and Sounds/bg music/orphanageNight.wav")
	Musicmanager.change_scene("orphanage_night")
	Musicmanager.normal_volume()
	#this one can be remove
	#Global2.complete_badge("badge5")
	#condition for merrick to be able to spawn
	if Global2.is_badge_complete("badge5"):
		merrick_sprite.show()
		arrow_head.show()
	else:
		merrick_sprite.hide()
		arrow_head.hide()

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null and Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("3")
		else:
			pass
			#print("position")
	else:
		if Global.map == "res://World/room/night/orphanage_basement_night.tscn":
			player.global_position = Global.get_player_current_position()
		else:
			pass
			#print("4")

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
	if  int(Dialogic.get_variable("introduction")) == 0:#first to trigger
		Musicmanager.set_to_low()
		var new_dialog = Dialogic.start('before_level2s1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint") #2nd
	elif tutorial_trigger == true:
		tutorial_trigger = false
		var new_dialog = Dialogic.start('level2s1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "badge6_done")
	elif Global2.is_badge_complete("badge6") && Global2.is_badge_complete("badge7") == false: #3rd to trigger
		Musicmanager.set_to_low()
		var new_dialog = Dialogic.start('level2s2p1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "asking_question_stage2")

	elif Global2.is_badge_complete("badge7") && Global2.is_badge_complete("badge10") == false:
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('level2s3chest') #4th to stage 3
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint_for_stage3")
	elif Global2.is_badge_complete("badge10") && Global2.is_badge_complete("badge11") == false:
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('level3s1') #4th to stage 3
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint_badge11")
	elif Global2.is_badge_complete("badge11") && Global2.is_badge_complete("badge12") == false:
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('level3s2') #4th to stage 3
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint_badge12")
	elif Global2.is_badge_complete("badge12") && Global2.is_badge_complete("badge13") == false:
		Musicmanager.set_to_low()
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('level3s3p0') #4th to stage 3
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint_badge13")
	else:
		Musicmanager.set_to_low()
		var new_dialog = Dialogic.start('ongoing_level1') #2nd to trigger to tutorial 1
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint_goings1")
		new_dialog.connect("dialogic_signal", self, "tutorial_stage1")

func interaction_endpoint_badge13(timelineend):
	Musicmanager.stop_music()
	Global.load_game_position = false
	SceneTransition.change_scene("res://Scenes/nigt_festival.tscn")

func interaction_endpoint_for_stage3(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()
	woodenchest_arrow_head.show()
	woodenchest_closed.show()
	woodenchest_collision.disabled = false
	woodensolid_chest_collision.disabled = false
	woodenchest_open.hide()
	#2nd chest
	#semi_woodenchest_closed.show() 
	#semi_woodenchest_solid_collision.disabled = true

func interaction_endpoint_badge12(timelineend):
	Global2.set_question(0, "What refers to a memory address that holds space for temporary data in C#?")
	Global2.set_answers(0, "Constant")
	Global2.set_answers(1, "String ")
	Global2.set_answers(2, "Variable")
	Global2.set_answers(3, "Boolean")
	Global2.set_feedback(0, "Incorrect. A constant holds data that cannot change, not temporary data.")
	Global2.set_feedback(1, "Incorrect. A string is a data type, but not the concept that refers to memory holding temporary data.")
	Global2.set_feedback(2, "Correct! A variable refers to a memory address that holds temporary data.")
	Global2.set_feedback(3, "Incorrect. Boolean is a data type, but it doesn't refer to the concept of temporary data storage.")
	Global2.correct_answer_ch1_3 = true
	#2nd question
	Global2.set_question(1, " In declaring variables, Data_type must be a valid C# data type including char, int, float, double, or any user defined data type")
	Global2.set_answers(4, "False")
	Global2.set_answers(5, "True ")
	Global2.set_answers(6, "Not sure ")
	Global2.set_answers(7, "No! ")
	Global2.set_feedback(4,"Incorrect. C# requires a valid data type, like int, char, or user-defined types.")
	Global2.set_feedback(5,"Correct! Variables in C# must have a valid data type.")
	Global2.set_feedback(6,"Data types like int, char, or custom types are required when declaring variables.")
	Global2.set_feedback(7,"Incorrect. C# requires valid data types, such as char, int, or user-defined types.")
	Global2.correct_answer_ch2_2 = true
	#3rd question
	Global2.set_question(2, "What separates identifiers in a variable list?")
	Global2.set_answers(8, "Plus ")
	Global2.set_answers(9, "Commas")
	Global2.set_answers(10, "Dot")
	Global2.set_answers(11, "slash")
	Global2.set_feedback(8,"Incorrect. The plus sign is used for addition or concatenation, not for separating variables.")
	Global2.set_feedback(9,"Correct! Commas are used to separate identifiers in a variable list.")
	Global2.set_feedback(10,"Incorrect. A dot is used for accessing properties or methods, not for separating variables.")
	Global2.set_feedback(11,"Incorrect. A slash is used in division or paths, not for separating variable identifiers.")
	Global2.correct_answer_ch3_2 = true
	
	Global.load_game_position = true
	Global2.dialogue_name = "badge12"
	SceneTransition.change_scene("res://intro/question_panel.tscn")

func interaction_endpoint_goings1(timelinename):
	player_controller.show()
	player_controller_joystick.enable_joystick()
	
func tutorial_stage1(param):
	if param == "tutorial":
		print("na trigger")
		tutorial_trigger = true
		#here I wanted to hide the contrller
	else:
		print("fail to load the dialogic")

func interaction_endpoint_badge11(timelineend):
	Global.load_game_position = true
	Global2.complete_badge("badge11")
	#player_controller.show()
	#player_controller_joystick.enable_joystick()
	var new_dialog = Dialogic.start('level3s2game') 
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_endpoint")

func badge6_done(timelineend):
	Global.load_game_position = true
	Global2.complete_badge("badge6")
	SceneTransition.change_scene("res://World/room/night/orphanage_basement_night.tscn")
	player_controller.show()
	player_controller_joystick.enable_joystick()

func asking_question_stage2(timelineend):
	
	Global2.set_question(0, "In a flowchart, what does a diamond shape usually represent?")
	Global2.set_answers(0, "Minecraft")
	Global2.set_answers(1, "Decision")
	Global2.set_answers(2, "Process")
	Global2.set_answers(3, "Input/Output")
	Global2.set_feedback(0, "What made you think that")
	Global2.set_feedback(1, "Correct!")
	Global2.set_feedback(2, "Process is square")
	Global2.set_feedback(3, "Input/Output is parallelogram")
	Global2.correct_answer_ch1_2 = true
	#2nd question
	Global2.set_question(1, "Which symbol is used as the on-page connector in a flowchart?")
	Global2.set_answers(4, "Circle")
	Global2.set_answers(5, "Square ")
	Global2.set_answers(6, "Diamond ")
	Global2.set_answers(7, "Oval ")
	Global2.set_feedback(4,"Correct!")
	Global2.set_feedback(5,"Square is for process")
	Global2.set_feedback(6,"Diamond is for decision")
	Global2.set_feedback(7,"Oval is for the start and termination")
	Global2.correct_answer_ch2_1 = true
	Global2.dialogue_name = "vallevel2s2"
	#3rd question
	Global2.set_question(2, "How many outcomes does a decision symbol typically have?")
	Global2.set_answers(8, "One ")
	Global2.set_answers(9, "two ")
	Global2.set_answers(10, "three ")
	Global2.set_answers(11, "four ")
	Global2.set_feedback(8,"Decision typically have yes/no outcome")
	Global2.set_feedback(9,"Correct!")
	Global2.set_feedback(10,"It does have yes or no outcome so just count them.")
	Global2.set_feedback(11,"Decision typically have yes/no outcome. 1 = yes, 2 = no")
	Global2.correct_answer_ch3_2 = true
	#4th question
	Global2.set_question(3, "Deciding whether to buy apples on the market. What symbol could correspond to decision?")
	Global2.set_answers(12, "Square")
	Global2.set_answers(13, "Arrow")
	Global2.set_answers(14, "Diamond")
	Global2.set_answers(15, "Parallelogram")
	Global2.set_feedback(12,"Square is for process")
	Global2.set_feedback(13,"Arrows can't produce yes or no questions")
	Global2.set_feedback(14,"Correct")
	Global2.set_feedback(15,"That is for input/output")
	Global2.correct_answer_ch4_3 = true
	#5th question
	Global2.set_question(4, "The flowchart is too long to fit into a canvas. What symbol to use to divide and connect the flowchart?")
	Global2.set_answers(16, "circle")
	Global2.set_answers(17, "diamond")
	Global2.set_answers(18, "sigma")
	Global2.set_answers(19, "division")
	Global2.set_feedback(16,"Correct!")
	Global2.set_feedback(17,"This is for decision")
	Global2.set_feedback(18,"what is the sigma? it was out of context answer")
	Global2.set_feedback(19,"Division sign is not used in flowchart layout")
	Global2.correct_answer_ch5_1 = true
	Global.load_game_position = true
	Global2.dialogue_name = "stageu2s2"
	SceneTransition.change_scene("res://intro/question_panel.tscn")
	
func level2s2_question(param):
	if param == "level2s2":
		Global2.complete_badge("badge6")

func interaction_endpoint(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

# When player near at merrick this will happen
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.load_game_position = true
	if woodenchest_collision.disabled == false or Global2.is_badge_complete("badge8") and Global2.is_badge_complete("badge10") == false:
		interacton_button.hide()
		arrow_head.hide()
	elif Global2.is_badge_complete("badge5"):
		interacton_button.show()
		arrow_head.hide()
	
func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if  woodenchest_collision.disabled == false or Global2.is_badge_complete("badge8"):
		interacton_button.hide()
		arrow_head.hide()
	elif Global2.is_badge_complete("badge5"):
		interacton_button.hide()
		arrow_head.show()
	
