extends Node2D

onready var animation = $AnimationPlayer
onready var interaction_button = $StaticBody2D/TextureButton
onready var coin_received_sounds = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("sparkle")
	animation.connect("animation_finished", self, "hiding_buttons")
	interaction_button.connect("pressed", self, "chest_open")

# Called when the player presses the interaction button
func chest_open():
	# Generate a random integer (0 or 1)
	var random_choice = randi() % 2  # This will give either 0 or 1

	if random_choice == 0:
		animation.play("sparkle_stop")
		var val_money = int(Dialogic.get_variable("val_money")) 
		val_money += 1
		Dialogic.set_variable("val_money", val_money)
		print(val_money)
	else:
		animation.play("sparkle_heart")
		if PlayerStats.health > 5:
			PlayerStats.health+=1
		else:
			PlayerStats.health = 5
	
	interaction_button.hide()  # Immediately hide the button when the chest is opened
	
	# Disconnect the signal if it's connected
	if interaction_button.is_connected("pressed", self, "chest_open"):
		interaction_button.disconnect("pressed", self, "chest_open")


# Hides and disables the button once the animation is done
func hiding_buttons(anim_name: String):
	if anim_name == "sparkle_stop":
		#print("Animation finished: " + anim_name)
		interaction_button.hide()  # Ensure the button is hidden
		# Disconnect the signal if it's connected
		if interaction_button.is_connected("pressed", self, "chest_open"):
			interaction_button.disconnect("pressed", self, "chest_open")

# Show the button when the player enters the interaction area (but only if it can still be pressed)
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if interaction_button.is_connected("pressed", self, "chest_open"):
		interaction_button.show()

# Hide the button when the player exits the interaction area
func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.hide()
