extends KinematicBody2D

const deatheffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $sprite
onready var animation = $AnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE
var last_direction = Vector2.RIGHT  # Store the last movement direction

func _physics_process(delta):
	match state:
		IDLE:
			play_idle_animation()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				#animation.play("attack")
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
		
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
				animation.play("walk_right")
			else:
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
			animation.play("idle_right")
		else:
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

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = deatheffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	queue_free()
	var enemyDeathEffect = deatheffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
