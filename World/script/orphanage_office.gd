extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
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
	Global2.set_question(0,"Pseudocode is written using _______ language rather than exact programming syntax.")
	Global2.set_answers(0,"English")
	Global2.set_answers(1,"Spanish")
	Global2.set_answers(2,"Tagalog")
	Global2.set_answers(3,"Japanese")
	Global2.set_picture_path(0,"res://Scenes/pictures/stage1/flowchart5.jpg")
	
	Global2.set_feedback(0,"Correct!")
	Global2.set_feedback(1,"wrong!, You must remember that it was a universal language")
	Global2.set_feedback(2,"No! It wasn't the Filipinos language.")
	Global2.set_feedback(3,"Did you already forget it?,  the answer was somehow connected to the americans")

	Global2.set_question(1,"This one element signify the beginning and end of flowchart")
	Global2.set_answers(4,"Terminol")
	Global2.set_answers(5,"Terminal")
	Global2.set_answers(6,"process")
	Global2.set_answers(7,"Decision")
	Global2.set_picture_path(1,"res://Scenes/pictures/stage1/flowchart6.jpg")
	
	Global2.set_feedback(4,"Nope, the answer starts with letter T but not this one.")
	Global2.set_feedback(5,"Correct!")
	Global2.set_feedback(6,"nope not the process. remember, It shape was looks like an oblong one.")
	Global2.set_feedback(7,"Wrong Valen!, you will lose heart for your mistake.")
	Global2.dialogue_name = "evaluation"
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_2 = true
	
	

