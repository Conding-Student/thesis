extends Node

#Badges, levels, stages
#var badge1 = false
#var badge2 = false
#var badge3 = false

#Stage 2 talking with the villiger number of times
#quest
var explore_town = 0
var lady_on_townsquare = 0
var manor_guard = 0
var paladin_mage_guild = 0
var after_quiz = 0


#levels UI triger cange
#var stage2_trigger = false

#var stage3_trigger = false

#Stage completion trigger for the display notification
#var stage1_complete = false 
#var stage2_complete = false
#var stage3_complete = false

######################## stage complete trigger ################
# Dictionary mapping badges to their completion status
var badges_complete = {
	"badge1": false,
	"badge2": false,
	"badge3": false,
	"badge4": false,
	"badge5": false
	
}

# Marks a badge as complete and displays a notification
func complete_badge(badge_name: String):
	if badges_complete.has(badge_name):
		badges_complete[badge_name] = true
		#print("%s badge earned!" % badge_name)

# Checks if a badge is complete
func is_badge_complete(badge_name: String) -> bool:
	return badges_complete.get(badge_name, false)

# Checks if all badges are earned
func are_all_badges_complete() -> bool:
	return not badges_complete.has_value(false)

######################## stage compelte trigger #################

################## PRE-POST TEST ###################
var pre_final_score = 0 # still not save in local file
var post_final_score = 0 #still not save in local file

var MPI = 30 - pre_final_score
var NRI =  ((post_final_score - pre_final_score) / MPI) * 100 # Need to be display

################## PRE-POST TEST ###################

######################### DYNAMIC QUIZ VALUES #######################
# Evaluation: using dictionaries for questions, answers, and feedback
var evaluations = {
	"questions": ["", "", "", "","",""],
	"answers": ["","", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", "", "",""],
	"feedback": ["", "", "", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", "",""],
	"pictures_path": ["res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png","res://intro/picture/question/default_bg.png","res://intro/picture/question/default_bg.png"],
}

#correct answer trigger
var correct_answer_ch1_1 = false
var correct_answer_ch1_2 = false
var correct_answer_ch1_3 = false
var correct_answer_ch1_4 = false
#Choices from 2nd question
var correct_answer_ch2_1 = false
var correct_answer_ch2_2 = false
var correct_answer_ch2_3 = false
var correct_answer_ch2_4 = false
#Choices from 3rd question
var correct_answer_ch3_1 = false
var correct_answer_ch3_2 = false
var correct_answer_ch3_3 = false
var correct_answer_ch3_4 = false
#Choices from 4th question
var correct_answer_ch4_1 = false
var correct_answer_ch4_2 = false
var correct_answer_ch4_3 = false
var correct_answer_ch4_4 = false
#Choices from 5th question
var correct_answer_ch5_1 = false
var correct_answer_ch5_2 = false
var correct_answer_ch5_3 = false
var correct_answer_ch5_4 = false

#fchange scene
var change_scene_on_question0 = false
var change_scene_on_question1 = false
var change_scene_on_question2 = false
var change_scene_on_question3 = false
var change_scene_on_question4 = false

# Array of trigger answers for each question
var trigger_answers = [
	[false, false, false, false],  # Question 1 choices
	[false, false, false, false],  # Question 2 choices
	[false, false, false, false],  # Question 3 choices
	[false, false, false, false],  # Question 4 choices
	[false, false, false, false]   # Question 5 choices
]

func reset_scene_change_flags():
	change_scene_on_question0 = false
	
	change_scene_on_question1 = false
	change_scene_on_question2 = false
	change_scene_on_question3 = false
	change_scene_on_question4 = false

# Function to reset all values to false
func reset_trigger_answers():
	for i in range(trigger_answers.size()):
		for j in range(trigger_answers[i].size()):
			trigger_answers[i][j] = false

# Function to get trigger value for a specific choice
func get_trigger_answer(question_index: int, choice_index: int) -> bool:
	return trigger_answers[question_index][choice_index]

# Function to set a trigger value for a specific choice
func set_trigger_answer(question_index: int, choice_index: int, value: bool):
	trigger_answers[question_index][choice_index] = value

# Example usage:
#var answer = get_trigger_answer(0, 2)  # Retrieves the trigger for the 3rd choice of the 1st question
#set_trigger_answer(0, 2, false)        # Sets the trigger for the 3rd choice of the 1st question to false

#dialogue name
var dialogue_name = ""

func reset_evaluations():
	# Reset the evaluation dictionary to default values
	evaluations = {
		"questions": ["", "", "", "", "", ""],
		"answers": ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
		"feedback": ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
		"pictures_path": [
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png"
		]
	}
	
	# Reset all correct answer triggers to false
	correct_answer_ch1_1 = false
	correct_answer_ch1_2 = false
	correct_answer_ch1_3 = false
	correct_answer_ch1_4 = false
	
	correct_answer_ch2_1 = false
	correct_answer_ch2_2 = false
	correct_answer_ch2_3 = false
	correct_answer_ch2_4 = false
	
	correct_answer_ch3_1 = false
	correct_answer_ch3_2 = false
	correct_answer_ch3_3 = false
	correct_answer_ch3_4 = false
	
	correct_answer_ch4_1 = false
	correct_answer_ch4_2 = false
	correct_answer_ch4_3 = false
	correct_answer_ch4_4 = false
	
	correct_answer_ch5_1 = false
	correct_answer_ch5_2 = false
	correct_answer_ch5_3 = false
	correct_answer_ch5_4 = false
	
	# Reset scene change triggers to false
	change_scene_on_question0 = false
	change_scene_on_question1 = false
	change_scene_on_question2 = false
	change_scene_on_question3 = false
	change_scene_on_question4 = false

######################### DYNAMIC QUIZ VALUES #######################

######################### Sequence logic ############################
# Dictionary to store the history of interactions
var interaction_history = {
	"interactions": []
}

# Function to add an interaction to the history
func add_interaction(question: String, user_answer: String, feedback: String, correct: bool) -> void:
	interaction_history["interactions"].append({
		"question": question,
		"user_answer": user_answer,
		"feedback": feedback,
		"correct": correct
	})

# Function to get the entire interaction history
func get_interaction_history() -> Dictionary:
	return interaction_history

# Function to clear the interaction history
func clear_interaction_history() -> void:
	interaction_history = {
		"interactions": []
	}

######################### Sequence Logic ############################

#Questions
func set_question(index: int, question_local: String):
	evaluations["questions"][index] = question_local

func get_question(index: int) -> String:
	return evaluations["questions"][index]
	
#answers
func set_answers(index: int, answers_local: String):
	evaluations["answers"][index] = answers_local

func get_answers(index: int) -> String:
	return evaluations["answers"][index]

#Questions
func set_feedback(index: int, feedback_local: String):
	evaluations["feedback"][index] = feedback_local

func get_feedback(index: int) -> String:
	return evaluations["feedback"][index]

func set_picture_path(index: int, picture_local: String):
	evaluations["pictures_path"][index] = picture_local
	
func get_picture_path(index: int) -> String:
	return evaluations["pictures_path"][index]
