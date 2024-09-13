extends Control

signal textbox_closed  # Signal emitted when the textbox is closed
var stats = PlayerStats  # Reference to the player's stats
export(Resource) var enemy = null  # Exported variable to set the enemy resource

var current_enemy_health = 0  # Variable to track the current health of the enemy

onready var battle_music = $AudioStreamPlayer
onready var hurt = $hurt
onready var hit = $hit
onready var die = $enemy_die


signal no_health


# Called when the node is added to the scene
func _ready():
	
	battle_music.play()
	
	# Connect the player's no_health signal to the _on_no_health function
	stats.connect("no_health", self, "_on_no_health")
	
	# Set the initial health values of the enemy in the progress bar
	set_health($enemy_container/ProgressBar, enemy.health, enemy.health)
	
	# Set the enemy texture in the UI
	$enemy_container/bat.texture = enemy.texture
	
	# Hide the textbox and question/answer panel initially
	$textbox.hide()
	q_and_a_hide()
	
	# Display a message indicating that the enemy has appeared
	display_text("A %s has appeared" % enemy.name)
	
	# Wait until the textbox_closed signal is emitted
	yield(self, "textbox_closed")
	
	# Show the question/answer panel
	q_and_a_show()
	
	# Initialize the current enemy health
	current_enemy_health = enemy.health

# Function to set up the health progress bar
func set_health(progressbar, health, max_health):
	progressbar.value = health
	progressbar.max_value = max_health
	progressbar.get_node("Label").text = "hp = %d/%d" % [health, max_health]

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
		print("failed to load "+result) 

# Display text in the textbox
func display_text(text):
	$textbox.show()
	$textbox/Label.text = text

# Handle the action when the list button is pressed
# Example script where you handle the scene change
func _on_list_pressed():
	$action_panel.hide()
	display_text("You successfully cast a spell")
	yield(self, "textbox_closed")
	
	# Decrease enemy health and update the health progress bar
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($enemy_container/ProgressBar, current_enemy_health, enemy.health)
	
	hit.play()
	#die.play()
	# Play the health hide animation and wait for it to finish
	$AnimationPlayer.play("enemy_damage")
	yield($AnimationPlayer, "animation_finished")    
	$AnimationPlayer.play("health_hide")
	yield($AnimationPlayer, "animation_finished")
	
	# Hide the question and answer panel
	q_and_a_hide()
	Global.set_player_position_engaged(Global.get_player_current_position())
	Global.set_enemy_state("enemy3", true)
	var result = get_tree().change_scene("res://levels/World.tscn")
	if result != OK:
		print("failed to load "+result)


# Display enemy dialogue sequence
func enemy_dialogue(first_d,second_d,feedback):
	q_and_a_hide()  # Hide Q&A panel
	display_text(first_d)
	yield(self, "textbox_closed")
	display_text(second_d)
	yield(self, "textbox_closed")
	
	$AnimationPlayer.play("shake")
	hurt.play()
	yield($AnimationPlayer,"animation_finished")
	# Decrease player health and play the shake animation
	stats.health = max(0, stats.health - 1)
	
	
	# Display the final message
	display_text(feedback)
	yield(self, "textbox_closed")
	q_and_a_show()  # Show Q&A panel again

# Handle the action when the data type button is pressed
func _on_data_type_pressed():
	enemy_dialogue("Novice!!","take my attack!","You must remember that it allows storing same datatype values.")

# Handle the action when the OOP button is pressed
func _on_OOP_pressed():
	enemy_dialogue("haha! fool!","Absorb my attack", "Your way too much advance")

# Handle the action when the Classes button is pressed
func _on_Classes_pressed():
	enemy_dialogue("haha! you already forgot it?", "You must die!","You shall go back a little bit!")
