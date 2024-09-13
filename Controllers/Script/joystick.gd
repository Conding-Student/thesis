extends Area2D

onready var big_circle = $BigCircle
onready var small_circle = $BigCircle/SmallCircle

onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big_circle.global_position)
		if not touched:
			if distance < max_distance:
				touched = true
		else:
			if event.is_pressed():
				small_circle.global_position = get_global_mouse_position()
				small_circle.position = big_circle.position + (small_circle.position - big_circle.position).limit_length(max_distance)
			else:
				touched = false
				small_circle.position = Vector2(0, 0)

func _process(_delta):
	if touched:
		small_circle.global_position = get_global_mouse_position()
		small_circle.position = big_circle.position + (small_circle.position - big_circle.position).limit_length(max_distance)

func get_velo():
	var joy_velo = Vector2(0, 0)
	
	if touched:
		var relative_position = small_circle.position - big_circle.position
		joy_velo = relative_position.normalized()
	
	return joy_velo


func _on_joystick_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	pass # Replace with function body.
