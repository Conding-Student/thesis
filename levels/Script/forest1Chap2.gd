extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var gandalf = $YSort/Gandalf
onready var gandalf_sprite = $YSort/Gandalf/Sprite
onready var gandalf_collision = $YSort/Gandalf/Area2D/CollisionShape2D
var current_map = "res://levels/Chapter2_maps/forest1Chap2.tscn"
var starting_player_position = Vector2  (36, 52)

onready var bug2_collision_question = $YSort/bugs/bug2/quiz/CollisionShape2D
onready var bug1_collision_question = $YSort/bugs/bug1/quiz/CollisionShape2D
onready var bug1_hitbox = $YSort/bugs/bug1/Hitbox/CollisionShape2D
onready var bug2_hitbox = $YSort/bugs/bug2/Hitbox/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Old Syntaxia forest"
	resume.connect("pressed", self, "resume_the_game")
	gandalf.connect("start_dialogue", self, "hide_controller")
	gandalf.connect("end_dialogue", self, "show_instruction")
	checking_gandalf_appearance()
	bug_question()
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	
func set_player_position():
	
	if  int(Dialogic.get_variable("gandalf")) == 0:
		print("dialogue trigger")
		introduction()
		player.global_position = starting_player_position
	elif Global.get_player_initial_position() == Vector2(0, 0):
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
			print("3")
		else:
			#pass
			print("4")
	else:
		player.global_position = Global.get_player_current_position()
		print("5")

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

############## interactions ################
func hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_instruction():
	hide_controller()
	gandalf.queue_free()
	var new_dialog = Dialogic.start('finding_house')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func introduction():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	var new_dialog = Dialogic.start('c2level1p1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func end_intructions(timelineend):
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()

func checking_gandalf_appearance():
	if int(Dialogic.get_variable("gandalf")) == 0: #if the first interaction with gandalf is not done this will happen
		gandalf_sprite.show()
		gandalf_collision.disabled = false
	else:
		#pass
		gandalf.queue_free()
		



func bug_question():
	if Global2.is_badge_complete("badge16"):
		bug1_collision_question.disabled = false
		bug2_collision_question.disabled = false
		bug2_hitbox.disabled = true
		bug1_hitbox.disabled = true
	else:
		bug1_collision_question.disabled = true
		bug2_collision_question.disabled = true

func _on_quizbug2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What operator should use to add the earned coins to your total.")
	Global2.set_answers(0, "==")
	Global2.set_answers(1, ">= ")
	Global2.set_answers(2, "+=")
	Global2.set_answers(3, "--")
	Global2.set_feedback(0, "Incorrect. == is used for comparison, not addition.")
	Global2.set_feedback(1, "Incorrect. >= is a comparison operator for greater than or equal to.")
	Global2.set_feedback(2, "Correct! += adds the earned coins to your total.")
	Global2.set_feedback(3, "Incorrect. -- decreases a value by 1, not adds to it.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level question/Stage 2 - 1.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	Global2.set_question(1, "What operator should use to increment your mana to fight this enemy longer?")
	Global2.set_answers(4, "<")
	Global2.set_answers(5, "> ")
	Global2.set_answers(6, "++")
	Global2.set_answers(7, "--")
	Global2.set_feedback(4, "Incorrect. < is a comparison operator for 'less than,' not for incrementing.")
	Global2.set_feedback(5, "Incorrect. > is a comparison operator for 'greater than,' not for incrementing.")
	Global2.set_feedback(6, "Correct! ++ increments your mana by 1.")
	Global2.set_feedback(7, "Incorrect. -- decreases a value by 1, not adds to it.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level question/Stage 2 - 2.png")
	Global2.set_question(2, "What operator should use to check if health is less than 30.")
	Global2.set_answers(8, "<")
	Global2.set_answers(9, "> ")
	Global2.set_answers(10, "<=")
	Global2.set_answers(11, "==")
	Global2.set_feedback(8, "Correct! < is used to check if health is less than 30.")
	Global2.set_feedback(9, "Incorrect. > checks if a value is greater, not less.")
	Global2.set_feedback(10, "Incorrect. <= checks if a value is less than or equal to, but the question only asks for 'less than'.")
	Global2.set_feedback(11, "Incorrect. == checks for equality, not whether a value is less than another.")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level question/Stage 2 - 3.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	Global.load_game_position = true
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_1 = true
	Global2.dialogue_name = "bug2"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")

#bug1
func _on_quiz_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What statement to use to be able for you to heal or attack based on your health.")
	Global2.set_answers(0, "drift-check")
	Global2.set_answers(1, "outfit-check")
	Global2.set_answers(2, "if-else")
	Global2.set_answers(3, "win-loss")
	Global2.set_feedback(0, "Incorrect. This isn't a valid statement in C#.")
	Global2.set_feedback(1, "Incorrect. This is not a valid statement in programming")
	Global2.set_feedback(2, "Correct! if-else allows you to make decisions based on your health condition.")
	Global2.set_feedback(3, "Incorrect. This is not a valid control statement in C#.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level question/Stage 2 - 4.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	Global2.set_question(1, "What operator should use to subtract 10 from the inventory?")
	Global2.set_answers(4, "<")
	Global2.set_answers(5, "> ")
	Global2.set_answers(6, "++")
	Global2.set_answers(7, "--")
	Global2.set_feedback(4, "Incorrect. < is a comparison operator for 'less than,' not for subtraction.")
	Global2.set_feedback(5, "Incorrect. > is a comparison operator for 'greater than,' not for subtraction.")
	Global2.set_feedback(6, "Incorrect. ++ increments a value by 1, not subtracts.")
	Global2.set_feedback(7, "Correct! -- subtracts 1, but if you want to subtract 10, use inventory -= 10;.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level question/Stage 2 - 5.png")
	Global2.set_question(2, "What operator should use to increment the counter")
	Global2.set_answers(8, "<")
	Global2.set_answers(9, "> ")
	Global2.set_answers(10, "<=")
	Global2.set_answers(11, "++")
	Global2.set_feedback(8, "Invorrect! < is a comparison operator for 'less than,' not for addition.")
	Global2.set_feedback(9, "Incorrect. > checks if a value is greater, not for addition")
	Global2.set_feedback(10, "Incorrect. <= checks if a value is less than or equal to, but the question only asks for 'less than'.")
	Global2.set_feedback(11, "Correct. ++ it increament the counter value by 1")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level question/Stage 2 - 6.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	Global.load_game_position = true
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_4 = true
	Global2.correct_answer_ch3_4 = true
	Global2.dialogue_name = "bug1"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")
