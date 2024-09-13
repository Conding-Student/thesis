extends Control

onready var option_menu = $Panel
onready var badges = $badges/Panel4
onready var book = $Spell_Book/Panel
onready var option = $settings/Panel
onready var save = $save_files/Panel
onready var confirmation = $back_to_menu/Panel
onready var restart_state = $save_files/saving_file

var initial_spawn_1st = Vector2(0,0) 

# Called when the node enters the scene tree for the first time.
func _ready():
	option_menu.hide()
	
func _on_restart_pressed():
	get_tree().paused = false
	PlayerStats.health
	Global.restarting()
	
	#print("onging")
	var result = get_tree().change_scene(Global.map)
	if result != OK:
		print("failed to load "+result)


func _on_bact_to_menu_pressed():
	confirmation.show()


func _on_badges_pressed():
	badges.show()


func _on_spellbook_pressed():
	book.show()


func _on_option_pressed():
	option.show()


func _on_save_pressed():
	Global.save_button_click = true
	save.show()
	

