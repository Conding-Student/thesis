extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player
onready var player_controller_joystick = $YSort/Player/Controller/joystick
onready var interaction_button = $YSort/people/merricks2/TextureButton
onready var place_name = $TopUi/Label2
var current_map = "res://World/room/orphanage_office.tscn"
var starting_player_position = Vector2(160, 170)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Orphanage Office"
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed", self, "merrick2")
	Global.set_map(current_map)



func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("2")
	
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("3")
	elif Global.get_player_current_position() != Vector2(0,0) and Global.player_position_retain == true:
		player.global_position = Global.get_player_current_position()
		
		
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			#print("4")
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
	else:
		player.global_position = Global.get_player_current_position()
		#print("last")

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

func after_tutorial_headings(timelinename):
	topui.show()
	player_controller.show()

func merrick2():
	player_controller.visible = false
	player_controller_joystick.disable_joystick()
	interaction_button.visible = false
	
	Global.set_map(current_map)
	var new_dialog = Dialogic.start('stage2')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_question_no")
	new_dialog.connect("dialogic_signal", self, "yes")


func after_question_no(timelineend):
	player_controller.visible = true
	player_controller_joystick.enable_joystick()
	

#after asnwering yes
func yes(param):
	###### trigger question feedback ###########
	Global2.set_question(0,"Pseudocode is written using _______ language rather than exact programming syntax.")
	Global2.set_answers(0,"English")
	Global2.set_answers(1,"Spanish")
	Global2.set_answers(2,"Tagalog")
	Global2.set_answers(3,"Japanese")
	
	
	Global2.set_feedback(0,"Correct!")
	Global2.set_feedback(1,"wrong!, You must remember that it was a universal language")
	Global2.set_feedback(2,"No! It wasn't the Filipinos language.")
	Global2.set_feedback(3,"Did you already forget it?,  the answer was somehow connected to the americans")

	Global2.set_question(1,"This one element signify the beginning and end of flowchart")
	Global2.set_answers(4,"Terminol")
	Global2.set_answers(5,"Terminal")
	Global2.set_answers(6,"process")
	Global2.set_answers(7,"Decision")
	
	
	Global2.set_feedback(4,"Nope, the answer starts with letter T but not this one.")
	Global2.set_feedback(5,"Correct!")
	Global2.set_feedback(6,"nope not the process. remember, It shape was looks like an oblong one.")
	Global2.set_feedback(7,"Wrong Valen!, you will lose heart for your mistake.")
	
	Global2.set_question(2, " Which shape is typically used to represent the start and end of a flowchart?")
	Global2.set_answers(8,"Oval")
	Global2.set_answers(9,"Rectangle")
	Global2.set_answers(10,"Square")
	Global2.set_answers(11,"Diamond")
	Global2.set_picture_path(2,"res://intro/picture/question/Flowchart_shape_unit1.png")
	
	Global2.set_feedback(8,"Correct!")
	Global2.set_feedback(9,"Not this one, This shape used to show process or action. It looks like a circle?")
	Global2.set_feedback(10,"nope, Square shape doesn't commonly used in flowcharting.")
	Global2.set_feedback(11,"Wrong Valen!, This diamond shape is most commonly used in decision making.")
	
	Global2.set_question(3, "A tool that can be used to write a preliminary plan for the development of a computer program.")
	Global2.set_answers(12,"Magnifyier")
	Global2.set_answers(13,"Machine")
	Global2.set_answers(14,"Pseudocode")
	Global2.set_answers(15,"Psycho")
	
	Global2.set_feedback(12, "Wrong! The right asnwer Starts with letter 'P' ")
	Global2.set_feedback(13, "Nope, This was to broad to be used in specific thing. The right asnswer have 'code' keyword")
	Global2.set_feedback(14, "Correct!")
	Global2.set_feedback(15, "Wrong! It was not even a tangible things!")
	
	Global2.set_question(4, "Does the IPO stand for Input Process Output?")
	Global2.set_answers(16,"No")
	Global2.set_answers(17,"Yes")
	Global2.set_answers(18,"Maybe")
	Global2.set_answers(19,"None")
	
	Global2.set_feedback(16, "Wrong!")
	Global2.set_feedback(17, "Correct")
	Global2.set_feedback(18, "Gotcha! it was either yes or no")
	Global2.set_feedback(19, "Wrong, the asnwer was either on the first three choices.")
	
	Global2.dialogue_name = "evaluation"
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_2 = true
	Global2.correct_answer_ch3_1 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_2 = true
	
	

