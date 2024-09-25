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

#choices 1 answer and feedback visibility
onready var question1_choice_one = $PanelContainer/question1/info/one
onready var question1_choice_two = $PanelContainer/question1/info/two
onready var question1_choice_three = $PanelContainer/question1/info/three
onready var question1_choice_four =  $PanelContainer/question1/info/four

onready var question2_choice_one = $PanelContainer/question2/info/one
onready var question2_choice_two = $PanelContainer/question2/info/two
onready var question2_choice_three = $PanelContainer/question2/info/three
onready var question2_choice_four = $PanelContainer/question2/info/four

onready var question3_choice_one = $PanelContainer/question3/info/one
onready var question3_choice_two = $PanelContainer/question3/info/two
onready var question3_choice_three = $PanelContainer/question3/info/three
onready var question3_choice_four = $PanelContainer/question3/info/four

onready var question4_choice_one = $PanelContainer/question4/info/one
onready var question4_choice_two = $PanelContainer/question4/info/two
onready var question4_choice_three = $PanelContainer/question4/info/three
onready var question4_choice_four = $PanelContainer/question4/info/four

onready var question5_choice_one = $PanelContainer/question5/info/one
onready var question5_choice_two = $PanelContainer/question5/info/two
onready var question5_choice_three = $PanelContainer/question5/info/three
onready var question5_choice_four = $PanelContainer/question5/info/four

#answers
onready var question1_answer1 = $PanelContainer/question1/info/one/answer
onready var question1_answer2 = $PanelContainer/question1/info/two/answer
onready var question1_answer3 = $PanelContainer/question1/info/three/answer2
onready var question1_answer4 = $PanelContainer/question1/info/four/answer3

onready var question2_answer1 = $PanelContainer/question2/info/one/answer
onready var question2_answer2 = $PanelContainer/question2/info/two/answer
onready var question2_answer3 = $PanelContainer/question2/info/three/answer2
onready var question2_answer4 = $PanelContainer/question2/info/four/answer3

onready var question3_answer1 = $PanelContainer/question3/info/one/answer
onready var question3_answer2 = $PanelContainer/question3/info/two/answer
onready var question3_answer3 = $PanelContainer/question3/info/three/answer2
onready var question3_answer4 = $PanelContainer/question3/info/four/answer3

onready var question4_answer1 = $PanelContainer/question4/info/one/answer
onready var question4_answer2 = $PanelContainer/question4/info/two/answer
onready var question4_answer3 = $PanelContainer/question4/info/three/answer2
onready var question4_answer4 = $PanelContainer/question4/info/four/answer3

onready var question5_answer1 = $PanelContainer/question5/info/one/answer
onready var question5_answer2 = $PanelContainer/question5/info/two/answer
onready var question5_answer3 = $PanelContainer/question5/info/three/answer2
onready var question5_answer4 = $PanelContainer/question5/info/four/answer3

#feedbacks
onready var question1_feedback1 = $PanelContainer/question1/info/one/feedback
onready var question1_feedback2 = $PanelContainer/question1/info/two/feedback
onready var question1_feedback3 = $PanelContainer/question1/info/three/feedback2
onready var question1_feedback4 = $PanelContainer/question1/info/four/feedback3

onready var question2_feedback1 = $PanelContainer/question2/info/one/feedback
onready var question2_feedback2 = $PanelContainer/question2/info/two/feedback
onready var question2_feedback3 = $PanelContainer/question2/info/three/feedback2
onready var question2_feedback4 = $PanelContainer/question2/info/four/feedback3

onready var question3_feedback1 = $PanelContainer/question3/info/one/feedback
onready var question3_feedback2 = $PanelContainer/question3/info/two/feedback
onready var question3_feedback3 = $PanelContainer/question3/info/three/feedback2
onready var question3_feedback4 = $PanelContainer/question3/info/four/feedback3

onready var question4_feedback1 = $PanelContainer/question4/info/one/feedback
onready var question4_feedback2 = $PanelContainer/question4/info/two/feedback
onready var question4_feedback3 = $PanelContainer/question4/info/three/feedback2
onready var question4_feedback4 = $PanelContainer/question4/info/four/feedback3

onready var question5_feedback1 = $PanelContainer/question5/info/one/feedback
onready var question5_feedback2 = $PanelContainer/question5/info/two/feedback
onready var question5_feedback3 = $PanelContainer/question5/info/three/feedback2
onready var question5_feedback4 = $PanelContainer/question5/info/four/feedback3

func _ready():
	#if question has been set for 1st and then so on
	if Global2.evaluations["questions"][0] != "":
		button1.disabled = false
		question1.text = Global2.get_question(0)
		if Global2.get_trigger_answer(0,0) == true:
			question1_choice_one.visible = true
			question1_answer1.text = Global2.get_answers(0)
			question1_feedback1.text = Global2.get_feedback(0)
		if Global2.get_trigger_answer(0,1) == true:
			question1_choice_two.visible = true
			question1_answer2.text = Global2.get_answers(1)
			question1_feedback2.text = Global2.get_feedback(1)
		if Global2.get_trigger_answer(0,2) == true:
			question1_choice_three.visible = true
			question1_answer3.text = Global2.get_answers(2)
			question1_feedback3.text = Global2.get_feedback(2)
		if Global2.get_trigger_answer(0,3) == true:
			question1_choice_four.visible = true
			question1_answer4.text = Global2.get_answers(3)
			question1_feedback4.text = Global2.get_feedback(3)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	#if question has been set for 1st and then so on
	if Global2.evaluations["questions"][1] != "":
		button2.disabled = false
		question2.text = Global2.get_question(1)
		if Global2.get_trigger_answer(1,0) == true:
			question2_choice_one.visible = true
			question2_answer1.text = Global2.get_answers(4)
			question2_feedback1.text = Global2.get_feedback(4)
		if Global2.get_trigger_answer(1,1) == true:
			question2_choice_two.visible = true
			question2_answer2.text = Global2.get_answers(5)
			question2_feedback2.text = Global2.get_feedback(5)
		if Global2.get_trigger_answer(1,2) == true:
			question2_choice_three.visible = true
			question2_answer3.text = Global2.get_answers(6)
			question2_feedback3.text = Global2.get_feedback(6)
		if Global2.get_trigger_answer(1,3) == true:
			question2_choice_four.visible = true
			question2_answer4.text = Global2.get_answers(7)
			question2_feedback4.text = Global2.get_feedback(7)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][2] != "":
		button3.disabled = false
		question3.text = Global2.get_question(2)
		if Global2.get_trigger_answer(2,0) == true:
			question3_choice_one.visible = true
			question3_answer1.text = Global2.get_answers(8)
			question3_feedback1.text = Global2.get_feedback(8)
		if Global2.get_trigger_answer(2,1) == true:
			question3_choice_two.visible = true
			question3_answer2.text = Global2.get_answers(9)
			question3_feedback2.text = Global2.get_feedback(9)
		if Global2.get_trigger_answer(2,2) == true:
			question3_choice_three.visible = true
			question3_answer3.text = Global2.get_answers(10)
			question3_feedback3.text = Global2.get_feedback(10)
		if Global2.get_trigger_answer(2,3) == true:
			question3_choice_four.visible = true
			question3_answer4.text = Global2.get_answers(11)
			question3_feedback4.text = Global2.get_feedback(11)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][3] != "":
		button4.disabled = false
		question4.text = Global2.get_question(3)
		if Global2.get_trigger_answer(3,0) == true:
			question4_choice_one.visible = true
			question4_answer1.text = Global2.get_answers(12)
			question4_feedback1.text = Global2.get_feedback(12)
		if Global2.get_trigger_answer(3,1) == true:
			question4_choice_two.visible = true
			question4_answer2.text = Global2.get_answers(13)
			question4_feedback2.text = Global2.get_feedback(13)
		if Global2.get_trigger_answer(3,2) == true:
			question4_choice_three.visible = true
			question4_answer3.text = Global2.get_answers(14)
			question4_feedback3.text = Global2.get_feedback(14)
		if Global2.get_trigger_answer(3,3) == true:
			question4_choice_four.visible = true
			question4_answer4.text = Global2.get_answers(15)
			question4_feedback4.text = Global2.get_feedback(15)
	else:
	# The question has not been set (is an empty string
		#print("Question at index", 0, "is still empty.")
		pass
	if Global2.evaluations["questions"][4] != "":
		button5.disabled = false
		question5.text = Global2.get_question(4)
		if Global2.get_trigger_answer(4,0) == true:
			question5_choice_one.visible = true
			question5_answer1.text = Global2.get_answers(16)
			question5_feedback1.text = Global2.get_feedback(16)
		if Global2.get_trigger_answer(4,1) == true:
			question5_choice_two.visible = true
			question5_answer2.text = Global2.get_answers(17)
			question5_feedback2.text = Global2.get_feedback(17)
		if Global2.get_trigger_answer(4,2) == true:
			question5_choice_three.visible = true
			question5_answer3.text = Global2.get_answers(18)
			question5_feedback3.text = Global2.get_feedback(18)
		if Global2.get_trigger_answer(4,3) == true:
			question5_choice_four.visible = true
			question5_answer4.text = Global2.get_answers(19)
			question5_feedback4.text = Global2.get_feedback(19)
	else:
	# The question has not been set (is an empty string
		pass
		#print("Question at index", 0, "is still empty.")

func _on_Question1_pressed():
	panel1.visible = true
	panel2.visible = false
	panel3.visible = false
	panel4.visible = false
	panel5.visible = false

func _on_Question2_pressed():
	panel1.visible = false
	panel2.visible = true
	panel3.visible = false
	panel4.visible = false
	panel5.visible = false

func _on_Question3_pressed():
	panel1.visible = false
	panel2.visible = false
	panel3.visible = true
	panel4.visible = false
	panel5.visible = false

func _on_Question4_pressed():
	panel1.visible = false
	panel2.visible = false
	panel3.visible = false
	panel4.visible = true
	panel5.visible = false

func _on_Question5_pressed():
	panel1.visible = false
	panel2.visible = false
	panel3.visible = false
	panel4.visible = false
	panel5.visible = true

func _on_next_stage_pressed():
	SceneTransition.change_scene(Global.get_map())
	Global2.reset_scene_change_flags()
	Global2.reset_trigger_answers()
	Global2.reset_evaluations()
	
	
	
	
