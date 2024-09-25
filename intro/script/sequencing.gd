extends Control

#ad ons update
onready var stage_label_update = $Label
onready var badges_update = $badges
onready var badge_label = $badges/Label

signal textbox_closed  # Signal emitted when the textbox is closed
var stats = PlayerStats

onready var hurt = $hurt
signal no_health

# Global node references
onready var feedback_textbox = $textbox
onready var feedback_label = $textbox/Label
onready var feedback_panel = $textbox  # Assuming the panel is the same as `feedback_textbox`

onready var instruction_panel_orig = $Question
onready var instruction_panel = $Question/q1
onready var action_panel = $action_panel
onready var player_panel = $player_panel

onready var textfield1 = $action_panel/user_input1/LineEdit
onready var textfield2 = $action_panel/user_input1/LineEdit2
onready var textfield3 = $action_panel/user_input1/LineEdit3
onready var textfield4 = $action_panel/user_input1/LineEdit4
onready var textfield5 = $action_panel/user_input1/LineEdit5
onready var submit_button = $Button

# Background picture
onready var bg_pic = $arena

# Tracking the current question index
var current_question_index = 0

#hide everything
func hide_everything():
	bg_pic.hide()
	instruction_panel.hide()
	action_panel.hide()
	feedback_panel.hide()
	player_panel.hide()
	instruction_panel_orig.hide()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the player's no_health signal to the _on_no_health function
	stats.connect("no_health", self, "_on_no_health")
	
	# Hide the button initially
	submit_button.hide()
	badge_label.hide()
	# Connect the text_changed signals of all textfields to the same function
	textfield1.connect("text_changed", self, "_on_textfield_text_changed")
	textfield2.connect("text_changed", self, "_on_textfield_text_changed")
	textfield3.connect("text_changed", self, "_on_textfield_text_changed")
	textfield4.connect("text_changed", self, "_on_textfield_text_changed")
	textfield5.connect("text_changed", self, "_on_textfield_text_changed")
	
	# Load the first question, feedback, and background when the scene loads
	load_question(0)

# Function to load questions, feedback, and images based on the index
func load_question(index: int):
	current_question_index = index  # Update the current question index
	
	var question = Global2.evaluations["questions"][index]
	
	# If the question is empty, hide the textfields and submit button
	if question.strip_edges() == "":
		hide_all_textfields()
		submit_button.hide()
		hide_everything()
		var new_dialog = Dialogic.start(Global2.dialogue_name)
		add_child(new_dialog)
		new_dialog.connect("dialogic_signal", self, "value_activating")
		new_dialog.connect("timeline_end", self, "end")
	else:
		show_only_relevant_textfield(index)
		instruction_panel.text = question
	
	# Update the background image
	bg_pic.texture = load(Global2.evaluations["pictures_path"][index])
	
	# Update the feedback textbox and label with the corresponding feedback
	feedback_label.text = Global2.evaluations["feedback"][index]

#trigger dialogue
func end(timelineend):
	pass

func value_activating(param):
	if param == "stage5done":
		Global2.complete_badge("badge5")
		Global2.state = "escape_door"
		Global.from_sequence = true
		badges_update.update_badges()
		#print("emit signal trigger okay toh")
		SceneTransition.change_scene("res://intro/stages_complete.tscn")
		
# Hide all textfields
func hide_all_textfields():
	textfield1.hide()
	textfield2.hide()
	textfield3.hide()
	textfield4.hide()
	textfield5.hide()

# Show only the relevant textfield based on the question index
func show_only_relevant_textfield(index: int):
	hide_all_textfields()
	match index:
		0:
			textfield1.show()
		1:
			textfield2.show()
		2:
			textfield3.show()
		3:
			textfield4.show()
		4:
			textfield5.show()

# Function that gets called when any textfield's text changes
func _on_textfield_text_changed(new_text):
	if textfield1.text.strip_edges() != "" or textfield2.text.strip_edges() != "" or textfield3.text.strip_edges() != "" or textfield4.text.strip_edges() != "" or textfield5.text.strip_edges() != "":
		submit_button.show()  # Show the button if any field has text
	else:
		submit_button.hide()  # Hide the button if all fields are empty

# Check the answer and provide feedback
func check_answer():
	var correct_answer = Global2.evaluations["answers"][current_question_index]
	var user_answer = get_relevant_user_answer(current_question_index)
	var wrong_feedback = Global2.evaluations["feedback"][current_question_index]

	if user_answer == correct_answer:
		# First handle heart feedback
		yield(need_hearts(), "completed")  # Wait for heart feedback to finish
		feedback_label.text = "Correct"  # Now show correct feedback

		if current_question_index + 1 < Global2.evaluations["questions"].size():
			load_question(current_question_index + 1)
		else:
			instruction_panel.text = "All questions completed!"
	else:
		Global2.interaction_history["interactions"][current_question_index] = user_answer
		feedback_orig(wrong_feedback)
		Global2.set_trigger_answer(0, current_question_index, true)
		enemy_dialogue(wrong_feedback)  # Trigger shaking and heart loss on wrong answer

# Get the relevant user input based on the current question
func get_relevant_user_answer(index: int) -> String:
	match index:
		0:
			return textfield1.text
		1:
			return textfield2.text
		2:
			return textfield3.text
		3:
			return textfield4.text
		4:
			return textfield5.text
		_:
			return ""

# Handle screen touch input to hide the textbox and emit the textbox_closed signal
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		$textbox.hide()
		emit_signal("textbox_closed")

# Handle the player's no_health signal
func _on_no_health():
	stats.health = 5  # Reset player's health
	var result = get_tree().change_scene("res://intro/Game_over.tscn")  # Change to Game Over scene
	if result != OK:
		print("failed to load " + result)

func q_and_a_show():
	$action_panel.show()
	$Question.show()
	submit_button.disabled = false
	submit_button.visible = false

# Hide the question and answer panel
func q_and_a_hide():
	$action_panel.hide()
	$Question.hide()
	submit_button.visible = true
	submit_button.disabled = true

# Show feedback when the player enters a wrong answer, triggers screen shake and heart loss
func enemy_dialogue(feedback):
	q_and_a_hide()
	display_text(feedback)
	yield(self, "textbox_closed")
	$AnimationPlayer.play("shake")
	hurt.play()
	yield($AnimationPlayer, "animation_finished")
	stats.health = max(0, stats.health - 1)  # Decrease health
	if stats.health <= 0:
		emit_signal("no_health")
	q_and_a_show()

# Check if the player needs more health (hearts)
func need_hearts():
	if stats.health == 5:
		display_text("No need to gain hearts!")
	else:
		stats.health = min(5, stats.health + 1)
		display_text("You gained 1 heart!")
	yield(self, "textbox_closed")  # Wait until the textbox is closed

# Handle displaying the feedback text
func display_text(text):
	$textbox.show()
	$textbox/Label.text = text

# Original feedback function (no scene change)
func feedback_orig(feedback):
	display_text(feedback)
	yield(self, "textbox_closed")

# Button press handling
func _on_Button_pressed():
	check_answer()
