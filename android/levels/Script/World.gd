extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Level
onready var player = $YSort/Player

onready var bat1 = $YSort/enemies/Bat
onready var demon1 = $YSort/enemies/Small_bugs
onready var big_bug = $YSort/enemies/bug

#NPC
onready var dialogue_button = $YSort/NPC/NPC/interaction_button2
onready var player_controls = $YSort/Player/Controller

var current_map = "res://levels/World.tscn"
var staring_player_position = Vector2(-121,-47)
#var starting_bat1_position = Vector2(-150,255)

func _ready():
	set_overall_initial_position()
	
	set_enemy_position(demon1,"enemy2")
	set_enemy_position(bat1,"enemy1")
	set_enemy_position(big_bug,"enemy3")
	
	set_player_position()
	
	
	Global.set_current_level(current_level.text)
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)


func after_tutorial_headings(timelinename):
	topui.show()
	player_controller.show()
	#print("two1")

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())
	Global.set_enemy_initial_position("enemy1",Global.get_enemy_current_position("enemy1"))
	Global.set_enemy_initial_position("enemy2",Global.get_enemy_current_position("enemy2"))
	Global.set_enemy_initial_position("enemy3",Global.get_enemy_current_position("enemy3"))

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0,0):
		Global.set_player_current_position(staring_player_position)
		print("one")
	
	elif Global.get_player_initial_position() != Vector2(0,0) and Global.player_position_retain == true:
		
		if Global.door_activated == true and Global.start_level_trigger == true:
			player.global_position = Vector2(-120,-56)
			Global.player_position_retain = false
			Global.door_activated = false
			Global.start_level_trigger = false
			topui.hide()
			player_controller.hide()
			var new_dialog = Dialogic.start('heading_tutorial')
			add_child(new_dialog)
			new_dialog.connect("timeline_end", self, "after_tutorial_headings")			
		
		elif Global.door_activated == true:
			player.global_position = Vector2(-120,-56)
			Global.player_position_retain = false
			Global.door_activated = false
			print("two")
			
		else:
			player.global_position = Global.get_player_position_engaged()
			Global.player_position_retain = false
			print("two3")
	elif Global.get_player_initial_position() != Vector2(0,0) and Global.get_enemy_defeated("enemy1") == true:
		print("three")
		player.global_position = Global.get_player_current_position()		
	else:
		print("four")
		player.global_position = Global.get_player_current_position()		

func set_enemy_position(name,enemy_number):
	if Global.get_enemy_current_position(enemy_number) == Vector2(0,0):		
		Global.set_enemy_current_position(enemy_number,Global.get_enemy_initial_position(enemy_number))					
	elif Global.get_enemy_current_position(enemy_number) != Vector2(0,0) and Global.get_enemy_state(enemy_number) == true:
		name.position = Global.get_enemy_engaged_position(enemy_number)
		name._on_Stats_no_health()
		Global.set_enemy_state(enemy_number, false)
		Global.set_enemy_defeated(enemy_number, true)		
	elif Global.get_enemy_current_position(enemy_number) != Vector2(0,0) and Global.get_enemy_defeated(enemy_number) == true:
		name.queue_free()
		name = null 
	else:
		name.position = name.global_position

func _process(_delta):
	Global.set_player_current_position(player.global_position)
	
	
	if Global.get_enemy_defeated("enemy1") == true or Global.get_enemy_defeated("enemy2") == true or Global.get_enemy_defeated("enemy3") == true:
		pass
	else:
		Global.set_enemy_current_position("enemy1",bat1.global_position)
		Global.set_enemy_current_position("enemy2",demon1.global_position)
		Global.set_enemy_current_position("enemy3",big_bug.global_position)
		

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

func enemy_engagement_plus_scene(enemy_keys, scene):
	Global.set_enemy_engaged_position(enemy_keys,Global.get_enemy_current_position(enemy_keys))
	Global.player_position_retain = true
	call_deferred("change_scene", scene)

#Bat1 area engagement
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_current_position(body.position)
	enemy_engagement_plus_scene("enemy1", "res://Battlescenes/battle_scene_forest.tscn") 

func change_scene(scene_path: String):
	get_tree().change_scene(scene_path)


func demon1_area_engagement(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_current_position(body.position) 
	enemy_engagement_plus_scene("enemy2","res://Battlescenes/battle_scene_forest-demon1.tscn")


func Big_bug_area_engagement(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_current_position(body.position) 
	enemy_engagement_plus_scene("enemy3","res://Battlescenes/battle_scene_forest-big_bug.tscn")


func npc_interaction_area(body_rid, body, body_shape_index, local_shape_index):
	dialogue_button.visible = true

func npc_interaction_area_exited(body_rid, body, body_shape_index, local_shape_index):
	dialogue_button.visible = false
	Global.dialogue1 = false

func after_dialog(timelinename):
	player_controls.visible = true
	dialogue_button.visible = true

func _on_interaction_button2_pressed():
	player_controls.visible = false
	dialogue_button.visible = false
	Global.dialogue1 == true
	var new_dialog = Dialogic.start('trial')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_dialog")


func house1_entered(body_rid, body, body_shape_index, local_shape_index):
	SceneTransition.change_scene("res://World/room/house_inside.tscn")

func entering_doors_marking(body_rid, body, body_shape_index, local_shape_index):
	Global.set_player_position_engaged(body.position)
