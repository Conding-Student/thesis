extends Node

onready var ui = $Panel4
onready var chapter_1 = $Panel4/Panel
onready var chapter_2 = $Panel4/Panel2
onready var chapter_3 = $Panel4/Panel3

#badges
onready var u1b1 = $Panel4/Panel/Badges/HBoxContainer/Units/b1
onready var u1s1 = $Panel4/Panel/Badges/HBoxContainer/Units/s1
onready var u1b2 = $Panel4/Panel/Badges/HBoxContainer/Units/b2
onready var u1s2 = $Panel4/Panel/Badges/HBoxContainer/Units/s2
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	chapter_1.show()

func _process(delta):
	if Global2.badge1 == true:
		u1b1.visible = true
		u1s1.visible = false
	if Global2.badge2 == true:
		u1b2.visible = true
		u1s2.visible = false
#chapter 1
func _on_close_button_pressed():
	ui.hide()

func _on_next_button_pressed():
	chapter_1.hide()
	chapter_2.show()
	
#chapter 2	
func _on_next_button2_pressed():
	chapter_2.hide()
	chapter_3.show()

func _on_previous_button2_pressed():
	chapter_2.hide()
	chapter_1.show()

func _on_close2_pressed():
	ui.hide()
	
#chapter 3	
func _on_previous_button3_pressed():
	chapter_3.hide()
	chapter_2.show()
	
func _on_close3_pressed():
	ui.hide()
