extends CanvasLayer


export var cooldown_time = 2.0  # Time in seconds before the button becomes available again

# Directly reference specific touchscreen buttons
onready var btn_attack = $BtnAttack
onready var btn_roll = $BtnRoll

func _ready():
	# Connect the "pressed" signal of each button to the _on_button_pressed function
	btn_attack.connect("pressed", self, "_on_button_pressed", [btn_attack])
	btn_roll.connect("pressed", self, "_on_button_pressed", [btn_roll])

func _on_button_pressed(button):
	# Disable the button and start cooldown
	button.disabled = true
	yield(get_tree().create_timer(cooldown_time), "timeout")
	button.disabled = false  # Re-enable the button
