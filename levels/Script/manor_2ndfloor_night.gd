extends Node2D
onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/player
onready var place_name = $TopUi/Label2
onready var door1_image = $YSort/objects/door
onready var door1_collision = $YSort/objects/door/Area2D/CollisionShape2D
onready var door1_collisionp = $YSort/objects/door/CollisionPolygon2D
onready var open_door1 = $YSort/objects/open_door
onready var meerick = $YSort/YSort/Sprite
onready var path_arrow = $YSort2/TileMap
#2nd door
onready var door2_image =$YSort/objects/door2 
onready var door2_collision =$YSort/objects/door2/Area2D/CollisionShape2D
onready var door2_collisionp =$YSort/objects/door2/CollisionPolygon2D
onready var open_door2 = $YSort/objects/open_door2
onready var merrick = $YSort/YSort/Sprite2
onready var path_arrow2 = $YSort2/TileMap2 
var current_map = "res://levels/stage_3_night/manor_2ndfloor_night.tscn"
var starting_player_position = Vector2 (528, 395)


func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Manor inside 2nd floor"
	Global.set_current_level(current_level.text)
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	first_dialogue()
	first_door()
	
	

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
			#print("Player position set from ", target_node_path)
	else:
		player.global_position = Global.get_player_current_position()
		#print("3")
		
func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())


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

func first_dialogue():
	if Global.get_door_state("manor_inside") == true && Global.get_door_state("door1") == false:
		player_controller.hide()
		var new_dialog = Dialogic.start('stage3p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint")
	else:
		print("error")

func interaction_endpoint(timelineend):
	player_controller.show()



func first_door():
	if Global.get_door_state("door1"):
		door1_image.hide()
		door1_collision.disabled = true
		door1_collisionp.disabled = true
		open_door1.show()
		meerick.hide()
		player_controller.hide()
		path_arrow.hide()
		var new_dialog = Dialogic.start('stage3p3')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "interaction_endpoint")
	elif Global.get_door_state("door2"):
		door2_image.hide()
		door2_collision.disabled = true
		door2_collisionp.disabled = true
		open_door2.show()
		merrick.hide()
		path_arrow2.hide()
		player_controller.hide()
	else:
		pass
		#print("door 1 false ")
		


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
		Global2.set_question(0,"In a flowchart, what does a diamond shape usually represent?")
		Global2.set_answers(0,"reading")
		Global2.set_answers(1,"Discussion")
		Global2.set_answers(2,"nothing")
		Global2.set_answers(3,"Decision")
		
		Global2.set_feedback(0,"Not this one, remember it uses if - else statement")
		Global2.set_feedback(1,"Wrong! The answer starts with 'D'")
		Global2.set_feedback(2,"Nope, It usually represent something")
		Global2.set_feedback(3,"Correct! This diamond shape is most commonly used in decision making.")

		Global2.dialogue_name = "stage3React2"
		Global2.correct_answer_ch1_4 = true
		
		SceneTransition.change_scene("res://intro/question_panel.tscn")



func _on_Area2D_body_shape_entered_door2(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0,"Complete the pseuducode. You must check if the chest is locked")
	Global2.set_answers(0,"chest is locked")
	Global2.set_answers(1,"door is locked")
	Global2.set_answers(2,"")
	Global2.set_answers(3,"Decision")
		
