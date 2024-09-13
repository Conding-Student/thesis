extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
onready var interaction_button = $YSort/people/merricks2/TextureButton

var current_map = "res://World/room/orphanage_office.tscn"
var starting_player_position = Vector2(160, 170)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
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
	player_controls.visible = false
	interaction_button.visible = false
	
	Global.set_map(current_map)
	var new_dialog = Dialogic.start('stage2')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_question_no")
	new_dialog.connect("dialogic_signal", self, "yes")

		
func after_question_no(timelineend):
	player_controls.visible = true
	

#after asnwering yes
func yes(param):
	###### trigger question feedback ###########
	Global2.set_question(0,"Which  magic is used to unlock doors, chest, and even decrypt complex key locks")
	Global2.set_answers(0,"List")
	Global2.set_answers(1,"Classcraft")
	Global2.set_answers(2,"OOP")
	Global2.set_answers(3,"Foreach")
	Global2.set_feedback(0,"Correct!")
	Global2.set_feedback(1,"wrong!, You must remember that it was vital in our line of work. ClassCraft was too advanced for you Valen")
	Global2.set_feedback(2,"No! Remember, we need to access its right index to unlock what's need to unlock")
	Global2.set_feedback(3,"Did you already forget it?, I didn't teach you about this magic but soon.")
	Global2.set_question(1,"How do can we unlock various things, by Accessing what specific things in ListKey Magic?")
	Global2.set_answers(4,"inbox")
	Global2.set_answers(5,"index")
	Global2.set_answers(6,"indoors")
	Global2.set_answers(7,"incode")
	Global2.set_feedback(4,"Nope, the answer count usually starts from ZERO, Remember that.")
	Global2.set_feedback(5,"Correct!, Think of an index as a marker that tells you the exact position of an item within a ListKey.")
	Global2.set_feedback(6,"we used ListKey Magic to unlock doors but INDOORS is not the right term")
	Global2.set_feedback(7,"Wrong Valen!, the right asnwer helps you quickly find and access items in ListKey Magic")
	Global2.dialogue_name = "evaluation"
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_2 = true
	
	

