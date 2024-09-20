extends Panel

# Define the signal
signal achievement_completed

onready var badge_display = [$normal, $semi, $master]  # Array for easier access
onready var timer = $Timer
onready var animation = $AnimationPlayer
onready var save_n_load = $saving_file
var current_badge = -1  # -1 means no badge is currently displayed

func _ready():
	# Initialize badge visibility
	for badge in badge_display:
		badge.visible = false
	
	# Ensure the timer is connected to the timeout function
	if not timer.is_connected("timeout", self, "_on_Timer_timeout"):
		timer.connect("timeout", self, "_on_Timer_timeout")
	
	check_badges()

# Call this function whenever a specific event occurs (e.g., player completes a task)
func check_badges():
	#print("Checking badges... Current badge: ", current_badge)
	
	if Global2.is_badge_complete("badge1") and current_badge != 0:
		#print("Badge 1 complete. Showing badge 1.")
		show_badge(0)  # Display first badge
		Global2.complete_badge("badge1")
		
	if Global2.is_badge_complete("badge2") and current_badge != 1:
		#print("Badge 2 complete. Showing badge 2.")
		show_badge(0)  # Display second badge (use correct index)
		Global2.complete_badge("badge2")
		
	if Global2.is_badge_complete("badge3") and current_badge != 2:
		#print("Badge 3 complete. Showing badge 3.")
		show_badge(0)  # Display third badge (use correct index)
		Global2.complete_badge("badge3")

# Call this function to show the badge and emit the signal
func show_badge(index):
	#print("Showing badge with index: ", index)
	
	# If the current badge is not the same as the one being shown
	if current_badge != index:
		# Hide the previous badge if one was shown
		if current_badge != -1:
			#print("Hiding current badge: ", current_badge)
			badge_display[current_badge].visible = false

		# Show the new badge
		badge_display[index].visible = true
		current_badge = index

		# Update player stats and save the game
		PlayerStats.health = 5
		#var text = "Badge %d Earned!" % (index + 1)
		#print(text)
		Global.set_current_level(Global.current_level)
		Global.save_triggered = true
		save_n_load.auto_save_file()

		# Emit the achievement_completed signal
		emit_signal("achievement_completed", index)

		# Start the timer to hide the badge after 3 seconds
		print("Starting timer for 3 seconds.")
		timer.start(3)

func _on_Timer_timeout():
	print("Timer timeout reached. Fading out badge.")
	
	# Play the fade-out animation and hide the badge
	animation.play("fade_out")
	SceneTransition.change_scene("res://intro/evaluation.tscn")
	if current_badge != -1:
		print("Hiding badge: ", current_badge)
		badge_display[current_badge].visible = false
		current_badge = -1  # Reset the current badge
