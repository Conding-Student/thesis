extends Node2D

onready var animation = $AnimationPlayer
export var heart_id: String = ""  # Unique ID for each bat

# Called when the node enters the scene tree for the first time.
func _ready():
	# Check the state from the Global singleton
	if not Global.get_bat_state(heart_id):
		print("heart is get on load, removing from scene: ID =", heart_id)  # Debugging print
		queue_free()  # If dead, remove from the scene
	else:
		print("not remove: ID =", heart_id)  # Debugging print
		animation.play("heart_jumping")
		
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if PlayerStats.health == 5:
		pass
	else:
		PlayerStats.health += 1
		Global.set_bat_state(heart_id, false) 
		queue_free()
