extends Panel

# Define the signal
signal achievement_completed

# Arrays to handle badge displays based on type
onready var badge_display = [$normal, $semi, $master]  # Array for easier access: normal, semi, master
onready var timer = $Timer
onready var animation = $AnimationPlayer
onready var save_n_load = $saving_file
var current_badge = -1  # -1 means no badge is currently displayed

# Badge order based on your logic
var badge_order = [
	"badge1", "badge2", "badge3", "badge4", "badge5", 
	"badge6", "badge7", "badge8", "badge9", "badge10", 
	"badge11", "badge12", "badge13", "badge14", "badge15",
	# Add as many badges as needed
]

func _ready():
	# Initialize badge visibility
	for badge in badge_display:
		badge.visible = false

	# Ensure the timer is connected to the timeout function
	if not timer.is_connected("timeout", self, "_on_Timer_timeout"):
		timer.connect("timeout", self, "_on_Timer_timeout")

	# Check badges to show the appropriate one
	check_badges()

func check_badges():
	# Loop over badge_order in reverse to check the latest completed badge
	for i in range(badge_order.size() - 1, -1, -1):
		var badge_name = badge_order[i]

		# Check if the badge is marked as complete in Global2
		if Global2.is_badge_complete(badge_name):
			# Display normal or semi badge depending on the milestone
			if is_milestone_badge(i + 1):  # i + 1 to get the badge number (badge1 is index 0)
				show_badge("semi", i)  # Show a semi badge
			else:
				show_badge("normal", i)  # Show a normal badge
			return  # Stop once we find the most recent completed badge


# Function to display the badge and emit the signal
func show_badge(badge_type, index):
	# Hide the current badge if any is visible
	if current_badge != -1:
		badge_display[current_badge].visible = false

	# Determine which badge to show based on the type
	if badge_type == "normal":
		badge_display[0].visible = true  # Show the normal badge
		current_badge = 0
	elif badge_type == "semi":
		badge_display[1].visible = true  # Show the semi badge
		current_badge = 1

	# Update player stats and trigger save
	PlayerStats.health = 5
	Global.set_current_level(Global.current_level)
	Global.save_triggered = true
	save_n_load.auto_save_file()

	# Emit the achievement_completed signal
	emit_signal("achievement_completed", index)

	# Start the timer to hide the badge after 3 seconds
	timer.start(3)

# Function to determine if the current badge is a milestone (semi badge)
# Milestone badges are every 5th badge: badge5, badge10, badge15, etc.
func is_milestone_badge(badge_number):
	return badge_number % 5 == 0

func _on_Timer_timeout():
	# Play the fade-out animation and hide the badge
	animation.play("fade_out")

	# Change the scene based on a global flag
	if Global.from_sequence == true:
		SceneTransition.change_scene("res://intro/evaluation_sequence.tscn")
	else:
		SceneTransition.change_scene("res://intro/evaluation.tscn")

	# Hide the current badge and reset current_badge
	if current_badge != -1:
		badge_display[current_badge].visible = false
		current_badge = -1

