extends Control




onready var question_label = $Question/q1  # Question label
onready var choices_panel = $action_panel/choices1  # Parent panel of buttons
onready var choices1 = $action_panel/choices1/ch1_1  # Button 1
onready var choices2 = $action_panel/choices1/ch1_2  # Button 2
onready var choices3 = $action_panel/choices1/ch1_3  # Button 3
onready var choices4 = $action_panel/choices1/ch1_4  # Button 4
onready var question_code_picture = $bg_pic5  # Image control for the question
onready var play_button = $Play_button

var current_question_index = 0  # Track the current question
var score = 0  # Track the user's score

var question_answers = {
	"questions": [
		"Question 1", "Question 2", "Question 3", "Question 4", "Question 5",
	],
	"answers": [
		["Answer 1a", "Answer 1b", "Answer 1c", "Answer 1d"],
		["Answer 2a", "Answer 2b", "Answer 2c", "Answer 2d"],
		["Answer 3a", "Answer 3b", "Answer 3c", "Answer 3d"],
		["Answer 4a", "Answer 4b", "Answer 4c", "Answer 4d"],
		["Answer 5a", "Answer 5b", "Answer 5c", "Answer 5d"],
	],
	"correct_answer": [
		[true, false, false, false],  # Correct answer for Q1
		[false, true, false, false],  # Correct answer for Q2
		[false, false, true, false],  # Correct answer for Q3
		[false, false, false, true],  # Correct answer for Q4
		[true, false, false, false],  # Correct answer for Q5
	],
	"images": [
		"res://intro/picture/question/question1.png",  # Image for Q1
		null,  # No image for Q2
		null,  # No image for Q3
		null,  # No image for Q4
		"res://Scenes/pictures/stage1/flowchart6.jpg",  # Image for Q5
	]
}

func _ready():
	choices1.connect("pressed", self, "_on_choice_selected", [0])
	choices2.connect("pressed", self, "_on_choice_selected", [1])
	choices3.connect("pressed", self, "_on_choice_selected", [2])
	choices4.connect("pressed", self, "_on_choice_selected", [3])
	display_question()

# Display the current question, answers, and image (if available)
func display_question():
	question_label.text = question_answers["questions"][current_question_index]
	choices1.text = question_answers["answers"][current_question_index][0]
	choices2.text = question_answers["answers"][current_question_index][1]
	choices3.text = question_answers["answers"][current_question_index][2]
	choices4.text = question_answers["answers"][current_question_index][3]

	var image_path = question_answers["images"][current_question_index]
	if image_path != null:
		question_code_picture.texture = load(image_path)
		question_code_picture.show()
	else:
		question_code_picture.hide()

# Handle when the user selects an answer
func _on_choice_selected(choice_index):
	if question_answers["correct_answer"][current_question_index][choice_index]:
		score += 1
		stats.health = min(stats.health + 1, 5)  # Add heart if correct, but cap at 5
		feedback_dialogue("Correct! You gained 1 heart.")
		yield(self, "textbox_closed")  # Wait for feedback before moving to next question
		current_question_index += 1  # Only increment the question index if the answer is correct
		
		if current_question_index < question_answers["questions"].size():
			display_question()  # Show the next question
		else:
			save_final_score()
	else:
		feedback_dialogue("Wrong answer. Try again.")  # Show feedback and stay on the same question
		yield(self, "textbox_closed")  # Wait for feedback before showing the question again
		display_question()  # Stay on the same question if incorrect

# Display feedback dialogue sequence
func feedback_dialogue(feedback):
	q_and_a_hide()
	display_text(feedback)
	yield(self, "textbox_closed")
	q_and_a_show()

# Display feedback in the textbox
func display_text(text):
	feedback_label.text = text
	feedback_panel.show()

# Hide the feedback box after pressing the screen
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		feedback_panel.hide()
		emit_signal("textbox_closed")

# Save the final score in the singleton
func save_final_score():
	Global2.pre_final_score = score
	show_final_score()

# Show the final score once all questions are answered
func show_final_score():
	question_label.text = "Quiz Completed! Your score: " + str(Global2.pre_final_score) + "/" + str(question_answers["questions"].size())
	choices_panel.hide()
	question_code_picture.hide()
	play_button.show()

# Play button handler
func _on_Play_button_pressed():
	SceneTransition.change_scene("res://Scenes/Intro-scene.tscn")

# Show the question and answer panel
func q_and_a_show():
	$action_panel.show()
	$Question.show()

# Hide the question and answer panel
func q_and_a_hide():
	$action_panel.hide()
	$Question.hide()
