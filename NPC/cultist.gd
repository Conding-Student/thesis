extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

onready var sprite = $character
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animation = $AnimationPlayer

onready var interaction_button = $TextureButton
onready var arrow_head = $talk_box

signal start_conversation
signal end_conversation
signal mission1_accepted

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO
var state = IDLE
var last_direction = Vector2.RIGHT  # Store the last movement direction

func _ready():
	#pass
	interaction_button.connect("pressed",self, "interaction")
	
func _physics_process(delta):
	match state:
		IDLE:
			play_idle_animation()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
	# Set the appropriate animation based on the movement direction
	if direction.length() > 0:  # Only update the direction if there is movement
		last_direction = direction
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.flip_h = false
				animation.play("walk_right")
			else:
				sprite.flip_h = false
				animation.play("walk_left")
		else:
			if direction.y > 0:
				animation.play("walk_down")
			else:
				animation.play("walk_up")

func play_idle_animation():
	# Play the idle animation based on the last direction
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			sprite.flip_h = false
			animation.play("idle_right")
		else:
			sprite.flip_h = false
			animation.play("idle_left")
	else:
		if last_direction.y > 0:
			animation.play("idle_down")
		else:
			animation.play("idle_up")

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

############################## interaction ####################
func interaction():
	interaction_button.hide()
	emit_signal("start_conversation")
	var new_dialog = Dialogic.start('cultist')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_end")
	new_dialog.connect("dialogic_signal", self, "mission")

func interaction_end(timelineend):
	emit_signal("end_conversation")

func mission(param):
	if param == "mission1_accepted":
		emit_signal("mission1_accepted")
	else:
		print("emit signal from dialogic failed")

func mission_completed():
	Dialogic.set_variable("bard_interaction", 2)
	var new_dialog = Dialogic.start('bard')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "interaction_end")
	
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.show()
	arrow_head.hide()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.hide()
	arrow_head.show()
