extends Control

# Question data (with 30 questions, answers, correct answers, and optional images)
var question_answers = {
	"questions": [
		"Question 1", "Question 2", "Question 3", "Question 4", "Question 5",
		"Question 6", "Question 7", "Question 8", "Question 9", "Question 10",
		"Question 11", "Question 12", "Question 13", "Question 14", "Question 15",
		"Question 16", "Question 17", "Question 18", "Question 19", "Question 20",
		"Question 21", "Question 22", "Question 23", "Question 24", "Question 25",
		"Question 26", "Question 27", "Question 28", "Question 29", "Question 30"
	],
	"answers": [
		["Answer 1a", "Answer 1b", "Answer 1c", "Answer 1d"],
		["Answer 2a", "Answer 2b", "Answer 2c", "Answer 2d"],
		["Answer 3a", "Answer 3b", "Answer 3c", "Answer 3d"],
		["Answer 4a", "Answer 4b", "Answer 4c", "Answer 4d"],
		["Answer 5a", "Answer 5b", "Answer 5c", "Answer 5d"],
		["Answer 6a", "Answer 6b", "Answer 6c", "Answer 6d"],
		["Answer 7a", "Answer 7b", "Answer 7c", "Answer 7d"],
		["Answer 8a", "Answer 8b", "Answer 8c", "Answer 8d"],
		["Answer 9a", "Answer 9b", "Answer 9c", "Answer 9d"],
		["Answer 10a", "Answer 10b", "Answer 10c", "Answer 10d"],
		["Answer 11a", "Answer 11b", "Answer 11c", "Answer 11d"],
		["Answer 12a", "Answer 12b", "Answer 12c", "Answer 12d"],
		["Answer 13a", "Answer 13b", "Answer 13c", "Answer 13d"],
		["Answer 14a", "Answer 14b", "Answer 14c", "Answer 14d"],
		["Answer 15a", "Answer 15b", "Answer 15c", "Answer 15d"],
		["Answer 16a", "Answer 16b", "Answer 16c", "Answer 16d"],
		["Answer 17a", "Answer 17b", "Answer 17c", "Answer 17d"],
		["Answer 18a", "Answer 18b", "Answer 18c", "Answer 18d"],
		["Answer 19a", "Answer 19b", "Answer 19c", "Answer 19d"],
		["Answer 20a", "Answer 20b", "Answer 20c", "Answer 20d"],
		["Answer 21a", "Answer 21b", "Answer 21c", "Answer 21d"],
		["Answer 22a", "Answer 22b", "Answer 22c", "Answer 22d"],
		["Answer 23a", "Answer 23b", "Answer 23c", "Answer 23d"],
		["Answer 24a", "Answer 24b", "Answer 24c", "Answer 24d"],
		["Answer 25a", "Answer 25b", "Answer 25c", "Answer 25d"],
		["Answer 26a", "Answer 26b", "Answer 26c", "Answer 26d"],
		["Answer 27a", "Answer 27b", "Answer 27c", "Answer 27d"],
		["Answer 28a", "Answer 28b", "Answer 28c", "Answer 28d"],
		["Answer 29a", "Answer 29b", "Answer 29c", "Answer 29d"],
		["Answer 30a", "Answer 30b", "Answer 30c", "Answer 30d"]
	],
	"correct_answer": [
		[true, false, false, false],  # Correct answer for Q1
		[false, true, false, false],  # Correct answer for Q2
		[false, false, true, false],  # Correct answer for Q3
		[false, false, false, true],  # Correct answer for Q4
		[true, false, false, false],  # Correct answer for Q5
		[false, true, false, false],  # Correct answer for Q6
		[false, false, true, false],  # Correct answer for Q7
		[false, false, false, true],  # Correct answer for Q8
		[true, false, false, false],  # Correct answer for Q9
		[false, true, false, false],  # Correct answer for Q10
		[false, false, true, false],  # Correct answer for Q11
		[false, false, false, true],  # Correct answer for Q12
		[true, false, false, false],  # Correct answer for Q13
		[false, true, false, false],  # Correct answer for Q14
		[false, false, true, false],  # Correct answer for Q15
		[false, false, false, true],  # Correct answer for Q16
		[true, false, false, false],  # Correct answer for Q17
		[false, true, false, false],  # Correct answer for Q18
		[false, false, true, false],  # Correct answer for Q19
		[false, false, false, true],  # Correct answer for Q20
		[true, false, false, false],  # Correct answer for Q21
		[false, true, false, false],  # Correct answer for Q22
		[false, false, true, false],  # Correct answer for Q23
		[false, false, false, true],  # Correct answer for Q24
		[true, false, false, false],  # Correct answer for Q25
		[false, true, false, false],  # Correct answer for Q26
		[false, false, true, false],  # Correct answer for Q27
		[false, false, false, true],  # Correct answer for Q28
		[true, false, false, false],  # Correct answer for Q29
		[false, true, false, false]   # Correct answer for Q30
	],
	"images": [
		"res://intro/picture/question/question1.png",  # Image for Q1
		null,  # No image for Q2
		null,  # No image for Q3
		null,  # No image for Q4
		"res://Scenes/pictures/stage1/flowchart6.jpg",  # Image for Q5
		null,  # No image for Q6
		null,  # No image for Q7
		null,  # No image for Q8
		null,  # No image for Q9
		null,  # No image for Q10
		null,  # No image for Q11
		null,  # No image for Q12
		null,  # No image for Q13
		null,  # No image for Q14
		null,  # No image for Q15
		null,  # No image for Q16
		null,  # No image for Q17
		null,  # No image for Q18
		null,  # No image for Q19
		null,  # No image for Q20
		null,  # No image for Q21
		null,  # No image for Q22
		null,  # No image for Q23
		null,  # No image for Q24
		null,  # No image for Q25
		null,  # No image for Q26
		null,  # No image for Q27
		null,  # No image for Q28
		null,  # No image for Q29
		null   # No image for Q30
	]
}


var current_question_index = 0  # Track the current question
var score = 0  # Track the user's score

onready var question_label = $Question/q1  # Question label
onready var choices_panel = $action_panel/choices1  # Parent panel of buttons
onready var choices1 = $action_panel/choices1/ch1_1  # Button 1
onready var choices2 = $action_panel/choices1/ch1_2  # Button 2
onready var choices3 = $action_panel/choices1/ch1_3  # Button 3
onready var choices4 = $action_panel/choices1/ch1_4  # Button 4
onready var question_code_picture = $bg_pic5  # Image control for the question
onready var play_button = $Play_button
func _ready():
	# Connect the button signals to handle the selected answer
	choices1.connect("pressed", self, "_on_choice_selected", [0])
	choices2.connect("pressed", self, "_on_choice_selected", [1])
	choices3.connect("pressed", self, "_on_choice_selected", [2])
	choices4.connect("pressed", self, "_on_choice_selected", [3])
	
	# Display the first question and its answers
	display_question()

# Display the current question, answers, and image (if available)
func display_question():
	# Update the question text
	question_label.text = question_answers["questions"][current_question_index]
	
	# Update the answer choices
	choices1.text = question_answers["answers"][current_question_index][0]
	choices2.text = question_answers["answers"][current_question_index][1]
	choices3.text = question_answers["answers"][current_question_index][2]
	choices4.text = question_answers["answers"][current_question_index][3]
	
	# Update the image (if it exists)
	var image_path = question_answers["images"][current_question_index]
	if image_path != null:
		question_code_picture.texture = load(image_path)
		question_code_picture.show()  # Show the image
	else:
		question_code_picture.hide()  # Hide the image if there's none

# Handle when the user selects an answer
func _on_choice_selected(choice_index):
	if question_answers["correct_answer"][current_question_index][choice_index]:
		score += 1  # Add points for the correct answer
	
	current_question_index += 1  # Move to the next question
	
	if current_question_index < question_answers["questions"].size():
		display_question()  # Display the next question
	else:
		save_final_score()  # Save the final score in the singleton and show the final score

# Store the final score in the singleton
func save_final_score():
	Global2.pre_final_score = score  # Save the final score in the singleton
	show_final_score()

# Show the final score once all questions are answered
func show_final_score():
	question_label.text = "Quiz Completed! Your score: " + str(Global2.pre_final_score) + "/" + str(question_answers["questions"].size())
	choices_panel.hide()  # Hide the buttons once the quiz is over
	question_code_picture.hide()  # Hide the image after the quiz
	play_button.show()


func _on_Play_button_pressed():
	SceneTransition.change_scene("res://Scenes/Intro-scene.tscn")
