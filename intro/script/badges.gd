extends Node

onready var ui = $Panel4
onready var chapter_1 = $Panel4/Panel
onready var chapter_2 = $Panel4/Panel2
onready var chapter_3 = $Panel4/Panel3

# Array of badge nodes for chapter 1
onready var badges = [
	$Panel4/Panel/Badges/HBoxContainer/Units/s1, #1
	$Panel4/Panel/Badges/HBoxContainer/Units/s2, #2
	$Panel4/Panel/Badges/HBoxContainer/Units/s3, #3
	$Panel4/Panel/Badges/HBoxContainer/Units/s4, #4
	$Panel4/Panel/Badges/HBoxContainer/Units/s5, #5
	$Panel4/Panel/Badges/HBoxContainer2/Units/s1, #6
	$Panel4/Panel/Badges/HBoxContainer2/Units/s2, #7
	$Panel4/Panel/Badges/HBoxContainer2/Units/s3, #8
	$Panel4/Panel/Badges/HBoxContainer2/Units/s4, #9
	$Panel4/Panel/Badges/HBoxContainer2/Units/s5  #10
]

# Array of badge images (default and completed)
var badge_images = {
	"badge1": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge2": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge3": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge4": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge5": {
		"default": preload("res://intro/picture/semi-mastery badges.png"),
		"earned": preload("res://intro/picture/semi-mastery.png"),
	},
	"badge6": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge7": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge8": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge9": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	},
	"badge10": {
		"default": preload("res://intro/picture/normal-badge-gray.png"),
		"earned": preload("res://intro/picture/normal badge.png"),
	}
}

# This is the label node reference for updating text
onready var progress_label =  $Label # Change path to your actual label

# Text map for displaying progress based on badge completion
var badge_text_map = {
	"badge1": "Chapter1 U1 2 / 5",
	"badge2": "Chapter1 U1 3 / 5",
	"badge3": "Chapter1 U1 4 / 5",
	"badge4": "Chapter1 U1 5 / 5",
	"badge5": "Chapter1 U2 1 / 5",
	"badge6": "Chapter1 U2 2 / 5",
	"badge7": "Chapter1 U2 3 / 5",
	"badge8": "Chapter1 U2 4 / 5",
	"badge9": "Chapter1 U2 5 / 5",
	"badge10": "Chapter1 U3 1 / 5"
}

func _ready():
	chapter_1.show()
	update_badges()

# Function to update badge visibility and label based on Global2 values
func update_badges():
	var latest_badge_text = ""  # Variable to hold the latest badge progress text

	for i in range(badges.size()):
		var badge_name = "badge" + str(i + 1)
		
		# Check if the badge is completed
		if Global2.is_badge_complete(badge_name):
			badges[i].texture = badge_images[badge_name]["earned"]  # Set earned image
			latest_badge_text = badge_text_map[badge_name]  # Update text for the latest completed badge
		else:
			badges[i].texture = badge_images[badge_name]["default"]  # Set default image

	# Update the label with the most recent completed badge's progress text
	if latest_badge_text != "":
		progress_label.text = latest_badge_text
		Global.set_current_level(latest_badge_text)  # Update global level text, if needed


# Chapter navigation functions
func _on_close_button_pressed():
	ui.hide()

func _on_next_button_pressed():
	chapter_1.hide()
	chapter_2.show()

func _on_next_button2_pressed():
	chapter_2.hide()
	chapter_3.show()

func _on_previous_button2_pressed():
	chapter_2.hide()
	chapter_1.show()

func _on_close2_pressed():
	ui.hide()

func _on_previous_button3_pressed():
	chapter_3.hide()
	chapter_2.show()

func _on_close3_pressed():
	ui.hide()
