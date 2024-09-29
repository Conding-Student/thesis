extends Node

onready var arrow_head = $arrow_head
onready var chest_closed = $iron_chest
onready var chest_collision = $iron_chest/Area2D/CollisionShape2D
onready var solid_chest_collision = $StaticBody2D/CollisionShape2D
onready var chest_open = $StaticBody2D/open

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Global2.is_badge_complete("badge10"):
		print("one")
		chest_open.show()
		solid_chest_collision.disabled = false
		chest_collision.disabled = true
		arrow_head.hide()
	elif Global2.is_badge_complete("badge9"):
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
	Global2.set_question(0,"The process need to start, write the 'start' keyword in pseudocode")
	Global2.set_answers(0, "start")
	Global2.set_feedback(0, "remember to put only the 'start' keyword no any other spaces")
	
	Musicmanager.set_to_low()
	Global2.set_picture_path(0,"res://intro/picture/question/level1/stage5/question2/Question # 2 - 1.png")
	#2nd 1uestion
	Global2.set_question(1,"Now you need to try to crack the lock, by inputting number 1. type this \n input number 1" )
	Global2.set_answers(1,"input number 1")
	Global2.set_feedback(1,"Remember to type the exact keywords and check for double spaces.")
	Global2.set_picture_path(1,"res://intro/picture/question/level1/stage5/question2/Question # 2 - 2.png")
	#3rd question
	Global2.set_question(2, "You've done it! but the lock is very tight input another number but this time it was number 2")
	Global2.set_answers(2,"input number 2")
	Global2.set_feedback(2,"Remember to type the exact keywords and check for double spaces. same answer on previous question but diferent number.")
	Global2.set_picture_path(2,"res://intro/picture/question/level1/stage5/question2/Question # 2 - 3.png")
	#4th question
	Global2.set_question(3,"Now you must display the result you should print the sum. 'print sum'" )
	Global2.set_answers(3,"print sum")
	Global2.set_feedback(3,"Remember to type the exact keywords and check for double spaces.")
	Global2.set_picture_path(3,"res://intro/picture/question/level1/stage5/question2/Question # 2 - 4.png")
	
	Global2.dialogue_name = "vallevel2s5"
	Global.load_game_position = true
	
	
	SceneTransition.change_scene("res://intro/sequencing.tscn")
