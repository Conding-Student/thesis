extends Control

onready var feedback_textbox = $textbox
onready var feedback_label = $textbox/Label
onready var feedback_panel = $textbox  # Assuming the panel is the same as `feedback_textbox`

onready var instruction_panel = $Question
onready var action_panel = $action_panel

onready var box1 = $action_panel/user_input1/LineEdit
onready var box2 = $action_panel/user_input1/LineEdit2
onready var box3 = $action_panel/user_input1/LineEdit3
onready var box4 = $action_panel/user_input1/LineEdit4
onready var box5 = $action_panel/user_input1/LineEdit5
onready var submit_button = $Button

signal textbox_closed  # Signal emitted when the textbox is closed
signal no_health  # Signal emitted when player health reaches zero

onready var hurt = $hurt # Player

var stats = PlayerStats

# Dictionary to store question, correct answers, and feedback
var question_data = {
	"question": "Use Listkey magic to open the door. Use the below formula to create Listkey magic. Magic name is 'key' and use 'int' datatype(T).",
	"correct_answers": {
		"box1": "IList<int>",
		"box2": "key",
		"box3": "=",
		"box4": "new List<int>",
		"box5": "();"
	},
	"feedback": {
		"box1": "Wrong box1: It is case sensitive, missing letters, or wrong datatype.\n",
		"box2": "Wrong box2: It is case sensitive or maybe missing letters.\n",
		"box3": "Wrong box3: Missing '='.\n",
		"box4": "Wrong box4: It is case sensitive, missing letters, space, or wrong datatype.\n",
		"box5": "Wrong box5: Missing symbol either (, ), or ;\n"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the text_changed signal for each LineEdit to the check_inputs function
	box1.connect("text_changed", self, "_on_text_changed")
	box2.connect("text_changed", self, "_on_text_changed")
	box3.connect("text_changed", self, "_on_text_changed")
	box4.connect("text_changed", self, "_on_text_changed")
	box5.connect("text_changed", self, "_on_text_changed")
	setting_char_limit()

func _on_text_changed(new_text):
	# Check if all LineEdits have a value
	submit_button.visible = box1.text.strip_edges() != "" and box2.text.strip_edges() != "" and box3.text.strip_edges() != "" and box4.text.strip_edges() != "" and box5.text.strip_edges() != ""

func setting_char_limit():
	box1.max_length = 10
	box2.max_length = 3
	box3.max_length = 1
	box4.max_length = 14
	box5.max_length = 4
	
func display_feedback(feedback):
	feedback_label.text = feedback
	adjust_feedback_panel_size()
	feedback_textbox.show()

func adjust_feedback_panel_size():
	# Adjust the panel size based on the label's text
	feedback_label.rect_min_size = Vector2(feedback_label.rect_min_size.x, feedback_label.get_line_height() * feedback_label.get_line_count() + 20)  # Add padding to the height

	# Adjust the feedback panel to fit the label's new size
	feedback_panel.rect_min_size = Vector2(feedback_panel.rect_min_size.x, feedback_label.rect_min_size.y + 20)  # Add some padding to the panel as well

# Handle screen touch input to hide the textbox and emit the textbox_closed signal
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		$textbox.hide()
		emit_signal("textbox_closed")

func q_and_a_hide():
	instruction_panel.hide()
	action_panel.hide()

func q_and_a_show():
	instruction_panel.show()
	action_panel.show()

func hurt_effect():
	q_and_a_hide()  # Hide Q&A panel
	$AnimationPlayer.play("shake")
	hurt.play()
	yield($AnimationPlayer, "animation_finished")
	stats.health = max(0, stats.health - 1)  # Decrease player health
	
	if stats.health == 0:
		emit_signal("no_health")

func _on_Button_pressed():
	submit_button.hide()

	# Concatenate all the input answers
	var user_answer = box1.text.strip_edges() + " " + box2.text.strip_edges() + " " + box3.text.strip_edges() + " " + box4.text.strip_edges() + " " + box5.text.strip_edges()
	
	# The correct answer
	var correct_answer = "IList<int> key = new List<int> ();"

	# Initialize feedback
	var feedback = ""
	var correct = true
	
	Global2.set_question(0, question_data["question"])
	
	# Check each box and accumulate errors using the dictionary
	if box1.text.strip_edges() != question_data["correct_answers"]["box1"]:
		Global2.set_trigger_answer(0, 0, true)
		correct = false
		feedback += question_data["feedback"]["box1"]
	if box2.text.strip_edges() != question_data["correct_answers"]["box2"]:
		Global2.set_trigger_answer(0, 0, true)
		correct = false
		feedback += question_data["feedback"]["box2"]
	if box3.text.strip_edges() != question_data["correct_answers"]["box3"]:
		Global2.set_trigger_answer(0, 0, true)
		correct = false
		feedback += question_data["feedback"]["box3"]
	if box4.text.strip_edges() != question_data["correct_answers"]["box4"]:
		Global2.set_trigger_answer(0, 0, true)
		correct = false
		feedback += question_data["feedback"]["box4"]
	if box5.text.strip_edges() != question_data["correct_answers"]["box5"]:
		correct = false
		Global2.set_trigger_answer(0, 0, true)
		feedback += question_data["feedback"]["box5"]
		
	# Compare the concatenated user answer to the correct answer
	if user_answer != correct_answer:
		correct = false
		feedback += "\nConcatenated answer is incorrect.\n"
		feedback += "Expected: " + correct_answer + "\n"
		feedback += "Received: " + user_answer + "\n"
		Global2.set_answers(0, user_answer)
		Global2.set_feedback(0, feedback)
		
	if correct:
		display_feedback("All boxes correct!")
		SceneTransition.change_scene("res://intro/Evaluation.tscn")
	else:
		hurt_effect()
		display_feedback(feedback)
		yield(self, "textbox_closed")
		q_and_a_show()
