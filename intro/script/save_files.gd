extends Node

onready var panel = $Panel
onready var saving_file = $saving_file
onready var auto = $Panel/MarginContainer/VBoxContainer/Auto as Button
onready var file1 = $Panel/MarginContainer/VBoxContainer/File1 as Button
onready var file2 = $Panel/MarginContainer/VBoxContainer/file2 as Button
onready var timer_function = $Panel/textbox/Timer
onready var notification_panel = $Panel/textbox


# Called when the node enters the scene tree for the first time.
func _ready():
	
	panel.hide()

	
	
	if Global.save_triggered == true or Global.save_button_click == true:
		saving_file.load_game_button()
		file1.text = Global.current_level
	else:
		auto.text = "Auto Save File"
		file1.text = "File 1"

	
	# Connect signals from buttons to respective functions
	auto.connect("pressed", self, "auto_save")
	file1.connect("pressed", self, "file1_pressed")
	#file2.connect("pressed", self, "file2_pressed")

func _process(delta):
	if Global.load_button_click == true:
		auto.disabled = false	
	if Global.save_button_click == true or Global.save_triggered == true:
		file1.disabled = false
		saving_file.load_game_button()
		file1.text = Global.current_level
	

func auto_save():
		
			saving_file.load_game_auto()
			Global.load_game_position = true
			SceneTransition.change_scene(Global.get_map())
			Global.load_button_click = false
			#Global.save_triggered = false	

func file1_pressed():
	if Global.load_button_click == true:
			saving_file.load_game()
			Global.load_game_position = true
			SceneTransition.change_scene(Global.get_map())
			Global.load_button_click = false
			#Global.save_triggered = false	
			#print("hello1")
	else:
		if Global.save_button_click == true:
			Global.save_triggered = true
			file1.text = Global.get_current_level()
			#Global.save_button_click = true
			saving_file.save_game()
			timer_feedback()
			#print(Global.save_button_click)
			#saving_file.load_game_button()
			
		else:
			file1.text = "File 1"
			#print("hello2")
func timer_feedback():
	timer_function.start(3)
	notification_panel.show()

func _on_close_pressed():
	panel.hide()
	#Global.save_triggered = false


func _on_Timer_timeout():
	notification_panel.hide()
