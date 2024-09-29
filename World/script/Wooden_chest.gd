extends Node


onready var arrow_head = $arrow_head
onready var chest_closed = $wooden_chest_closed
onready var chest_collision = $wooden_chest_closed/Area2D/CollisionShape2D
onready var solid_chest_collision = $StaticBody2D/CollisionShape2D
onready var chest_open = $StaticBody2D/open

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Global2.is_badge_complete("badge8"):
		chest_open.show()
		solid_chest_collision.disabled = false
		chest_collision.disabled = true
	else:
		arrow_head.hide()
		chest_closed.hide()
		chest_open.hide()
		solid_chest_collision.disabled = true
		chest_collision.disabled = true


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Identify the wrong shapes, did you notice what shape should'nt use in decision making?")
	Global2.set_answers(0, "Circle")
	Global2.set_answers(1, "rectangle")
	Global2.set_answers(2, "square")
	Global2.set_answers(3, "parallelogram")
	Global2.set_feedback(0, "Nope, it was use in connecting flowchart")
	Global2.set_feedback(1, "Not this one, This shape used to show process or action.")
	Global2.set_feedback(2, "nope, Square shape doesn't commonly used in flowcharting.")
	Global2.set_feedback(3, "Correct")
	Global2.correct_answer_ch1_4 = true
	Global2.set_picture_path(0, "res://intro/picture/question/level2/stage3/Question 1.png")
	#2nd question
	Global2.set_question(1, "Connect the two connectors by identifying the missing letter inside the highlighted connector symbol")
	Global2.set_answers(4, "D")
	Global2.set_answers(5, "C")
	Global2.set_answers(6, "A")
	Global2.set_answers(7, "B")
	Global2.set_feedback(4, "Connectors needs to have the same letter inside to be connected")
	Global2.set_feedback(5, "Connectors needs to have the same letter inside to be connected")
	Global2.set_feedback(6, "Correct")
	Global2.set_feedback(7, "Connectors needs to have the same letter inside to be connected")
	Global2.correct_answer_ch2_3 = true
	Global2.set_picture_path(1, "res://intro/picture/question/level2/stage3/Question 2 .png")
	Global2.dialogue_name = "level2s3"
	Global.load_game_position = true
	SceneTransition.change_scene("res://intro/question_panel.tscn")
