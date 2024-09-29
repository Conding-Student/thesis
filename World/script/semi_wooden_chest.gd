extends Node2D


onready var arrow_head = $arrow_head
onready var chest_closed = $semi_wooden_chest
onready var chest_collision = $semi_wooden_chest/Area2D/CollisionShape2D
onready var solid_chest_collision = $StaticBody2D/CollisionShape2D 
onready var chest_open = $StaticBody2D/open

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global2.is_badge_complete("badge9"):
		print("one")
		chest_open.show()
		solid_chest_collision.disabled = false
		chest_collision.disabled = true
		arrow_head.hide()
	elif Global2.is_badge_complete("badge8"):
		print("two")
		arrow_head.show()
		chest_closed.show()
		solid_chest_collision.disabled = false
		chest_collision.disabled = false
	else:
		arrow_head.hide()
		chest_closed.hide()
		chest_open.hide()
		solid_chest_collision.disabled = true
		chest_collision.disabled = true




func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, " Which shape is typically used to represent the start and end of a flowchart?")
	Global2.set_answers(0,"Oval")
	Global2.set_answers(1,"Rectangle")
	Global2.set_answers(2,"Square")
	Global2.set_answers(3,"Diamond")
	Global2.set_picture_path(0,"res://intro/picture/question/Flowchart_shape_unit1.png")
	Global2.set_feedback(0,"Correct!")
	Global2.set_feedback(1,"Not this one, This shape used to show process or action. It looks like a circle?")
	Global2.set_feedback(2,"nope, Square shape doesn't commonly used in flowcharting.")
	Global2.set_feedback(3,"Wrong Valen!, This diamond shape is most commonly used in decision making.")
	
	Global2.set_question(1, "A tool that can be used to write a preliminary plan for the development of a computer program.")
	Global2.set_answers(4,"Magnifyier")
	Global2.set_answers(5,"Machine")
	Global2.set_answers(6,"Pseudocode")
	Global2.set_answers(7,"Psycho")
	Global2.set_feedback(4, "Wrong! The right asnwer Starts with letter 'P' ")
	Global2.set_feedback(5, "Nope, This was to broad to be used in specific thing. The right asnswer have 'code' keyword")
	Global2.set_feedback(6, "Correct!")
	Global2.set_feedback(7, "Wrong! It was not even a tangible things!")
	
	Global2.dialogue_name = "level2s4"
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_3 = true
	Global.load_game_position = true
	
	SceneTransition.change_scene("res://intro/question_panel.tscn")
