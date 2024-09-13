
extends Control

signal textbox_closed  # Signal emitted when the textbox is closed
var stats = PlayerStats  # Reference to the player's stats

var current_enemy_health = 0  # Variable to track the current health of the enemy

onready var question_text = $Question/text
onready var question_action_second = $action_panel/actions2
onready var question_action_first = $action_panel/actions
onready var hurt = $hurt

signal no_health

# Called when the node is added to the scene
func _ready():
	stats.connect("no_health", self, "_on_no_health")
	question_action_second.visible = false
	q_and_a_show()
	Global2.set_question(0,"Which  magic is used to unlock doors, chest, and even decrypt complex key locks")

# Show the question and answer panel
func q_and_a_show():
	$action_panel.show()
	$Question.show()

# Hide the question and answer panel
func q_and_a_hide():
	$action_panel.hide()
	$Question.hide()

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

# Display text in the textbox
func display_text(text):
	$textbox.show()
	$textbox/Label.text = text

# Display enemy dialogue sequence
func enemy_dialogue(first_d, second_d, feedback):
	q_and_a_hide()  # Hide Q&A panel
	display_text(first_d)
	yield(self, "textbox_closed")
	display_text(second_d)
	yield(self, "textbox_closed")
	$AnimationPlayer.play("shake")
	hurt.play()
	yield($AnimationPlayer, "animation_finished")
	# Decrease player health and play the shake animation
	stats.health = max(0, stats.health - 1)
	# Display the final message
	display_text(feedback)
	yield(self, "textbox_closed")
	q_and_a_show()  # Show Q&A panel again

func next_question(question):
	if stats.health == 5:
		# don't increase the health
		stats.health = max(0, stats.health + 0)
	else:
		# increase the health bu one
		stats.health = max(0, stats.health + 1)
	question_text.text = question

func feedback(first_d, second_d, feedback, change_scene_on_feedback=false):
	q_and_a_hide()  # Hide Q&A panel
	display_text(first_d)
	yield(self, "textbox_closed")
	display_text(second_d)
	yield(self, "textbox_closed")
	# Display the final message
	display_text(feedback)
	yield(self, "textbox_closed")
	q_and_a_show()  # Show Q&A panel again
	if change_scene_on_feedback:
		var new_dialog = Dialogic.start('evaluation')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end")

#vacant purpose to avoid error
func end():
	pass

func change_scene(scene_path):
	var result = get_tree().change_scene(scene_path)
	if result != OK:
		print("failed to load " + result)

# Handle the action when the list button is pressed
func _on_list_pressed():
	$action_panel.hide()
	feedback("Correct!", "Using this we can penetrate various buildings by decrypting their locks", "You will be rewarded by a new heart!")
	next_question("How do can we unlock various things, by Accessing what specific things in ListKey Magic?")
	
	#settingup values for evaluation
	Global2.set_question(1, "How do can we unlock various things, by Accessing what specific things in ListKey Magic?")
	Global2.set_answers(0,"List")
	Global2.set_feedback(0,"Correct!")
	
	question_action_second.visible = true
	question_action_first.visible = false
	#getting the choose answers
	

# Handle the action when the OOP button is pressed
func _on_OOP_pressed():
	enemy_dialogue("No!", "Where did you get this idea?", "Remember, we need to access its right index to unlock what's need to unlock")
	
	#setting up values for evaluation
	Global2.set_answers(1,"OOP")
	Global2.set_feedback(1,"No!, Remember, we need to access its right index to unlock what's need to unlock")
	
# Handle the action when the Classes button is pressed
func _on_classcraft_pressed():
	enemy_dialogue("Wrong!", "You will get punished for every wrong answer", "You must remember that it was vital in our line of work. ClassCraft was too advanced for you Valen")
	#setting up values for evaluation
	Global2.set_answers(2,"ClassCraft")
	Global2.set_feedback(2,"Wrong!, ClassCraft was too advanced for you")
	
	
# Handle the action when the foreach button is pressed
func _on_foreach_pressed():
	enemy_dialogue("Did you already forget it?", "You must listen whenever I teach you!", "I didn't teach you about this magic but later.")
	#setting up values for evaluation
	Global2.set_answers(3,"Foreach")
	Global2.set_feedback(3,"Did you already forget it?, I didn't teach you about this magic but later.")
# Handle the action when the inbox button is pressed
func _on_inbox_pressed():
	enemy_dialogue("Nope, ListKey magic is not an E-mail or mailbox", "Let me give you a hint", "the answer count usually starts from ZERO, Remember that.")
	
	#setting up values for evaluation
	Global2.set_answers(5,"inbox")
	Global2.set_feedback(5,"Nope, the answer count usually starts from ZERO, Remember that.")
	
# Handle the action when the index button is pressed
func _on_index_pressed():
	
	Global2.stage2_complete = true
	Global2.badge2 = true
	Global2.stage2_trigger = false
	Global2.stage3_trigger = true
	Global.player_position_retain = true

	feedback("Correct!", "Exactly! now you completely understand what ListKey Magic", "Think of an index as a marker that tells you the exact position of an item within a ListKey.", true)
	#setting up values for evaluation
	Global2.set_answers(4,"Index")
	Global2.set_feedback(4,"Correct!, Think of an index as a marker that tells you the exact position of an item within a ListKey.")
	if stats.health == 5:
		# don't increase the health
		stats.health = max(0, stats.health + 0)
	else:
		# increase the health bu one
		stats.health = max(0, stats.health + 1)
# Handle the action when the indoors button is pressed
func _on_indoors_pressed():
	enemy_dialogue("Haha! Are you kidding me?", "Now I knew you never listened to me", "Yup, we used ListKey Magic to unlock doors but INDOORS is not the right term")
	#setting up values for evaluation
	Global2.set_answers(6,"Indoors")
	Global2.set_feedback(6,"we used ListKey Magic to unlock doors but INDOORS is not the right term")
	
	
# Handle the action when the incode button is pressed
func _on_incode_pressed():
	enemy_dialogue("Wrong Valen!", "It sounds magical but it was not the right answer", "The right asnwer helps you quickly find and access items in ListKey Magic")
	#setting up values for evaluation
	Global2.set_answers(7,"Incode")
	Global2.set_feedback(7,"Wrong Valen!, the right asnwer helps you quickly find and access items in ListKey Magic")
