extends TextureRect
#panels
onready var panel1 = $PanelContainer/question1
onready var panel2 = $PanelContainer/question2
onready var panel3 = $PanelContainer/question3
onready var panel4 = $PanelContainer/question4
onready var panel5 = $PanelContainer/question5

#buttons
onready var button1 = $Control/ScrollContainer/VBoxContainer/Question1
onready var button2 = $Control/ScrollContainer/VBoxContainer/Question2
onready var button3 = $Control/ScrollContainer/VBoxContainer/Question3
onready var button4 = $Control/ScrollContainer/VBoxContainer/Question4
onready var button5 = $Control/ScrollContainer/VBoxContainer/Question5

#questions
onready var question1 = $PanelContainer/question1/info/question
onready var question2 = $PanelContainer/question2/info/question
onready var question3 = $PanelContainer/question3/info/question
onready var question4 = $PanelContainer/question4/info/question
onready var question5 = $PanelContainer/question5/info/question

#Right answer
onready var right_answer1 = $PanelContainer/question1/info/correction/answer
onready var right_answer2 = $PanelContainer/question2/info/correction/answer
onready var right_answer3 = $PanelContainer/question3/info/correction/answer
onready var right_answer4 = $PanelContainer/question4/info/correction/answer
onready var right_answer5 = $PanelContainer/question5/info/correction/answer


#user answer
onready var user_answer1 = $PanelContainer/question1/info/correction/answer
onready var user_answer2 = $PanelContainer/question2/info/correction/answer
onready var user_answer3 = $PanelContainer/question3/info/correction/answer 
onready var user_answer4 = $PanelContainer/question4/info/correction/answer
onready var user_answer5 = $PanelContainer/question5/info/correction/answer

#feedbacks
onready var question1_feedback1 = $PanelContainer/question1/info/answer/feedback
onready var question2_feedback2 = $PanelContainer/question2/info/answer/feedback
onready var question3_feedback3 = $PanelContainer/question3/info/answer/feedback
onready var question4_feedback4 = $PanelContainer/question4/info/answer/feedback
onready var question5_feedback5 = $PanelContainer/question5/info/answer/feedback

func _ready():
	
	#if question has been set for 1st and then so on
	if Global2.evaluations["questions"][0] != "":
		button1.disabled = false
		user_answer1.text = Global2.get_answers(0)
		question1.text = Global2.get_question(0)
		question1_feedback1.text = Global2.get_feedback(0)
		right_answer1.text = Global2.get_answers_sequence(0)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][1] != "":
		button2.disabled = false
		right_answer2.text = Global2.get_answers(1)
		question2.text = Global2.get_question(1)
		question2_feedback2.text = Global2.get_feedback(1)
		user_answer2.text = Global2.get_answers_sequence(1)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][2] != "":
		button3.disabled = false
		right_answer3.text = Global2.get_answers(2)
		question3.text = Global2.get_question(2)
		question3_feedback3.text = Global2.get_feedback(2)
		user_answer3.text = Global2.get_answers_sequence(2)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][3] != "":
		button4.disabled = false
		right_answer4.text = Global2.get_answers(3)
		question4.text = Global2.get_question(3)
		question4_feedback4.text = Global2.get_feedback(3)
		user_answer4.text = Global2.get_answers_sequence(3)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][4] != "":
		button5.disabled = false
		right_answer5.text = Global2.get_answers(4)
		question5.text = Global2.get_question(4)
		question5_feedback5.text = Global2.get_feedback(4)
		user_answer5.text = Global2.get_answers_sequence(4)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	
func _on_Question1_pressed():
	panel1.show()
	panel2.hide()

func _on_Question2_pressed():
	panel1.hide()
	panel2.show()
	panel3.hide()
	panel4.hide()
	panel5.hide()

func _on_Question3_pressed():
	panel1.hide()
	panel2.hide()
	panel3.show()
	panel4.hide()
	panel5.hide()

func _on_Question4_pressed():
	panel1.hide()
	panel2.hide()
	panel3.hide()
	panel4.show()
	panel5.hide()

func _on_Question5_pressed():
	panel1.hide()
	panel2.hide()
	panel3.hide()
	panel4.hide()
	panel5.show()


func _on_next_stage_pressed():
	print("nasa evalutation scene ako at yung nasa babako")
	print(Global.from_sequence)
	SceneTransition.change_scene(Global.map)
	Global2.reset_evaluations()
	Global2.reset_interactions()
