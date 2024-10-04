extends KinematicBody2D

onready var talk_box = $talk_box
onready var interaction_button = $TextureButton
onready var gandalf_collision = $CollisionShape2D
onready var sprite = $Sprite
signal start_dialogue
signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_button.connect("pressed",self, "interaction_start")
	if int(Dialogic.get_variable("gandalf")) == 0: #if the first interaction with gandalf is not done this will happen
		sprite.show()
		gandalf_collision.disabled = false
	else:
		pass

func interaction_start():
	emit_signal("start_dialogue")
	var new_dialog = Dialogic.start('c2level1p2')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_interaction")

func end_interaction(timelineend):
	emit_signal("end_dialogue")

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	talk_box.hide()
	interaction_button.show()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	talk_box.show()
	interaction_button.hide()
