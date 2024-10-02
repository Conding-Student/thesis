extends Node2D

onready var animationplayer = $AnimationPlayer
onready var arrow_head = $arrow_head
onready var chest_closed = $chest_closed
onready var interaction_button = $TextureButton
var trigger = false
signal chest_has_been_opened
# Called when the node enters the scene tree for the first time.
func _ready():
	chest_closed.hide()
	arrow_head.hide()
	interaction_button.connect("pressed",self,"opening_chest")


func chest_mission_available():
	trigger = true
	chest_closed.show()
	arrow_head.show()

func opening_chest():
	interaction_button.hide()
	animationplayer.play("chest_opening")
	emit_signal("chest_has_been_opened")

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if trigger == true && int(Dialogic.get_variable("bard_interaction")) != 2:
		arrow_head.hide()
		interaction_button.show()
	else:
		arrow_head.hide()
		interaction_button.hide()
		print("magical chest hide")


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if trigger == true && int(Dialogic.get_variable("bard_interaction")) != 2:
		arrow_head.show()
		interaction_button.hide()
	else:
		print("magical chest condition error")
	
