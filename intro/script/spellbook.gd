extends Node

onready var ui = $Panel
onready var methods = $methods
onready var class_info = $class_info
onready var list_panel = $Panel/in_game/list
onready var class_panel = $Panel/in_game/Class
onready var oop_panel = $Panel/in_game/OOP
onready var m_list_panel = $Panel/module/list
onready var m_class_panel = $Panel/module/Class
onready var m_oop_panel = $Panel/module/OOP
onready var module_def = $Panel/module
onready var in_Game_def = $Panel/in_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#ui.hide()

func _on_close_pressed():
	ui.hide()

#list picture whe click it shows methods
func _on_pictureIG_pressed():
	methods.show()


func _on_list_next_button_pressed():
	list_panel.visible = false
	class_panel.visible = true

#class button whe click it shows methods
func _on_class_previous_button_pressed():
	list_panel.visible = true
	class_panel.visible = false

func _on_class_next_button_pressed():
	class_panel.visible = false
	oop_panel.visible = true

#OOP button whe click it shows methods
func _on_oop_previous_button_pressed():
	class_panel.visible = true
	oop_panel.visible = false

# buttons for spellbook definitions
func _on_Module_define_pressed():
	in_Game_def.visible = false
	module_def.visible = true

func _on_ingame_pressed():
	in_Game_def.visible = true
	module_def.visible = false
	
# buttons for module game definitions
func _on_mdef_list_next_button_pressed():
	m_list_panel.visible = false
	m_class_panel.visible = true

func _on_mdef_class_previous_button_pressed():
	m_list_panel.visible = true
	m_class_panel.visible = false

func _on_mdef_class_next_button_pressed():
	m_class_panel.visible = false
	m_oop_panel.visible = true

func _on_mdef_oop_previous_button_pressed():
	m_class_panel.visible = true
	m_oop_panel.visible = false

# buttons for module game definitions Classes
func _on_module_classes_info_pressed():
	class_info.visible = true


func _on_module_definition_class_pressed():
	class_info.visible = true
