extends Node

onready var ui = $Panel4
onready var chapter_1 = $Panel4/Panel
onready var chapter_2 = $Panel4/Panel2
onready var chapter_3 = $Panel4/Panel3

# Array of badge nodes for chapter 1
onready var badges = [
	$Panel4/Panel/Badges/HBoxContainer/Units/s1,
	$Panel4/Panel/Badges/HBoxContainer/Units/s2,
	$Panel4/Panel/Badges/HBoxContainer/Units/s3,
	$Panel4/Panel/Badges/HBoxContainer/Units/s4,
	$Panel4/Panel/Badges/HBoxContainer/Units/s5
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
		"earned": preload("res://intro/picture/semi-mastery.png")
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	chapter_1.show()
	update_badges()  # Initial update of badge visibility and images

# Function to update badge visibility and images based on Global2 values
# Function to update badge visibility and images based on Global2 values
func update_badges():
	for i in range(badges.size()):
		var badge_name = "badge" + str(i + 1)  # badge1, badge2, etc.
		if Global2.badges_complete.has(badge_name) and Global2.badges_complete[badge_name]:
			badges[i].texture = badge_images[badge_name]["earned"]  # Set earned image
			#print("%s badge earned, displaying earned image." % badge_name)
		else:
			badges[i].texture = badge_images[badge_name]["default"]  # Set default image
			#print("%s badge not earned, displaying default image." % badge_name)


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
