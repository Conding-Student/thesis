extends Node2D


onready var animation_player = $AnimationPlayer

signal start_interaction
signal end_interaction

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("New Anim")

func interaction_end(timelineend):
	SceneTransition.change_scene("res://intro/sequencing.tscn")

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global2.is_badge_complete("badge15"):
		Musicmanager.stop_music()
		SceneTransition.change_scene("res://Scenes/timetravel.tscn")
	else:
		
		Global2.set_question(0, "Declare a datatype that can stored words or phrases. Usually it uses double aphosthrope for its value")
		Global2.set_answers(0, "string")
		Global2.set_feedback(0, "The correct syntax is string.")
		#2nd question
		Global2.set_question(1, "Declare a variable name for the datatype of string.\nName it as book since it was the item that you want to retrieve.")
		Global2.set_answers(1, "book")
		Global2.set_feedback(1,"The named should be book. Since it was the item that you want to retrieve")
		#Declare string variable name 'locktype' with a value of 'magic' 
		#3rd question
		Global2.set_question(2, "After choosing datatype and declaring variable name you should use the right \nsign to assign value on it")
		Global2.set_answers(2, '=')
		Global2.set_feedback(2,'equal sign that should be the right answer')
		#4th question
		Global2.set_question(3, "Now stored a value from the variable you created named it as secrets since that book contains secret information")
		Global2.set_answers(3, '"secrets"')
		Global2.set_feedback(3, 'Incorrect. The correct syntax for assigning value is: "secrets" . Make sure to use the correct value and the right format! do not forget the double aphosthrophe')
		
		#4th question
		Global2.set_question(4, "Every variable declaration must be end. Put the ending symbol of semi-colon")
		Global2.set_answers(4, ';')
		Global2.set_feedback(4, 'Incorrect. The correct syntax is: ;')
		
		Global2.dialogue_name = "level3done"
		
		# dialog
		emit_signal("start_interaction")
		var new_dialog = Dialogic.start('level3book')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_end")
	
	
	
