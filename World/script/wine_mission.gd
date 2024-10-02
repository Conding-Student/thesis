extends Node2D

onready var wine_bottle = $wine_bottle
onready var arrow_head = $arrow_head
onready var interaction_button = $TextureButton
onready var collision = $Area2D/CollisionShape2D

signal start_dialogue
signal end_dialogue
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_button.connect("pressed", self, "bottle_fetch")
	if int(Dialogic.get_variable("cultist_mission")) == 1:
		wine_bottle.show()
		arrow_head.show()
		collision.disabled = false
	else:
		collision.disabled = true
		wine_bottle.hide()
		arrow_head.hide()

func bottle_fetch():
	emit_signal("start_dialogue")
	var new_dialog = Dialogic.start('wine_mission')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_end")

func interaction_end(timelineend):
	emit_signal("end_dialogue")
	queue_free()

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	arrow_head.hide()
	interaction_button.show()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	arrow_head.show()
	interaction_button.hide()
