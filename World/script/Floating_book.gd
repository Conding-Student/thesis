extends Node2D


onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("New Anim")


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Declare int variable name 'lockno' with a value of 1")
	Global2.set_answers(0, "int lockno = 1;")
	Global2.set_feedback(0, "The correct syntax is int 'lockno' = 1;. Make sure to include the data type and semi-colon. Use the correct format!")
	#2nd question
	Global2.set_question(1, "Declare Double variable name 'level' with a value of 5.9")
	Global2.set_answers(1, "double level = 5.9;")
	Global2.set_feedback(1,"You need to declare a double like this: double level = 5.9;. Make sure to use the correct data type and semi-colon. Use the format!")
	#Declare string variable name 'locktype' with a value of 'magic' 
	#3rd question
	Global2.set_question(2, "Declare string variable name 'locktype' with a value of 'magic'")
	Global2.set_answers(2, 'string locktype = "magic";')
	Global2.set_feedback(2,'Incorrect. To declare a string, the correct syntax is: string locktype = "magic";. Ensure you are using double quotes for the string value and the correct data type. Also semi-colon')
	#4th question
	Global2.set_question(3, "Declare bool variable name 'isLocked' with a value of false")
	Global2.set_answers(3, "bool islocked = false;")
	Global2.set_feedback(3, "Incorrect. The correct syntax for declaring a boolean is: bool isLocked = false;. Make sure to use the correct data type and the right format! do not forget the semi-colon")
	SceneTransition.change_scene("res://intro/sequencing.tscn")
