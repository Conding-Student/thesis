extends Node

# Variables
var save_triggered = false
var player_position_engaged = Vector2(0, 0)
var player_position_retain = false
var player_initial_position = Vector2(0, 0)
var player_current_position = Vector2(0, 0)
var player_after_door_position = Vector2(0, 0)

var dialogue_start_tutorial = false
var start_level_trigger = false
var door_activated = false
var load_game_position = false
var from_level

#came from sequence scene trigger
var from_sequence = false

# Settings
var mute_trigger = false

#NPC
var dialogue1 = false

# ENEMY
var enemy_current_position = {"enemy1": Vector2(0, 0),"enemy2": Vector2(0, 0),"enemy3": Vector2(0, 0)}
var enemy_initial_position = {"enemy1": Vector2(0, 0),"enemy2": Vector2(0, 0),"enemy3": Vector2(0, 0)}
var enemy_engaged_position = {"enemy1": Vector2(0, 0),"enemy2": Vector2(0, 0),"enemy3": Vector2(0, 0)}
var enemy_state = {"enemy1": false, "enemy2": false, "enemy3": false}
var enemy_defeated = {"enemy1": false, "enemy2": false, "enemy3": false}

var map = ""
var current_level = "Chapter1 U1 1 / 5"
var save_button_click = false
var load_button_click = false

# Dialogue before the quest and answer
var dialogue_states = {}


#Declare those door that has been opened
var door_states = {}

# Declare and initialize the dictionary to store the bat states
var bat_states = {}  # Add this line at the top


# Function to set the state of a dialogue (open or closed)
func set_dialogue_state(dialogue_id: String, is_open: bool):
	dialogue_states[dialogue_id] = is_open

# Function to get the state of a dialogue, defaulting to closed (false) if not set
func get_dialogue_state(dialogue_id: String) -> bool:
	# Default to false if not set
	return dialogue_states.get(dialogue_id, false)

# Function to return the door name if it exists
func get_door_name(door_name: String) -> String:
	if door_states.has(door_name):
		return door_name  # Return the name (key) itself
	else:
		return "Door not found"

# Function to set the state of a bat (alive or dead)
func set_door_state(door_id: String, is_open: bool):
	#print("Setting bat state: ID =", bat_id, "Alive =", is_alive)  # Debugging print
	door_states[door_id] = is_open

# Function to get the state of a bat, defaulting to alive if not set
func get_door_state(door_id: String) -> bool:
	var state = door_states.get(door_id, false)  # Default to true (alive) if not set
	#print("Getting bat state: ID =", bat_id, "Alive =", state)  # Debugging print
	return state


# Function to set the state of a bat (alive or dead)
func set_bat_state(bat_id: String, is_alive: bool):
	#print("Setting bat state: ID =", bat_id, "Alive =", is_alive)  # Debugging print
	bat_states[bat_id] = is_alive

# Function to get the state of a bat, defaulting to alive if not set
func get_bat_state(bat_id: String) -> bool:
	var state = bat_states.get(bat_id, true)  # Default to true (alive) if not set
	#print("Getting bat state: ID =", bat_id, "Alive =", state)  # Debugging print
	return state

# Restarting function
func restarting():
	# Reset player-related variables
	save_triggered = true
	Global.player_current_position = Global.player_initial_position
	Global.player_initial_position = Vector2(0,0)
	Global.player_position_retain = false
	Global.player_position_engaged = Vector2(0,0)
	
	start_level_trigger = false

	# Reset enemy-related variables
	#Global.enemy_current_position = Global.get_enemy_current_position()
	#Global.enemy_initial_position = {"enemy1": Vector2(0, 0)}
	#Global.enemy_engaged_position = {"enemy1": Vector2(0, 0)}
	#Global.enemy_state = {"enemy1": false}
	#Global.enemy_defeated = {"enemy1": false}

	# Reset level-related variables
	current_level = ""
	save_button_click = false

func set_player_after_door_position(new_position: Vector2) -> void:
	player_after_door_position = new_position
	
func get_player_after_door_position() -> Vector2:
	return player_after_door_position

func set_player_position_engaged(new_position: Vector2) -> void:
	player_position_engaged = new_position
	
func get_player_position_engaged() -> Vector2:
	return player_position_engaged

func get_player_initial_position() -> Vector2:
	return player_initial_position

func set_player_initial_position(new_position: Vector2) -> void:
	player_initial_position = new_position
	
func get_player_current_position() -> Vector2:
	return player_current_position

func set_player_current_position(new_position: Vector2) -> void:
	player_current_position = new_position

func get_current_level():
	return current_level

func set_current_level(new_level):
	current_level = new_level

func set_map(new_map):
	map = new_map

func get_map():
	return map

# ENEMIES
func get_enemy_defeated(key) -> bool:
	return enemy_defeated[key]

func set_enemy_defeated(key,position: bool):
	enemy_defeated.erase(key)
	enemy_defeated[key] = position
	
func get_enemy_state(key) -> bool:
	return enemy_state[key]

func set_enemy_state(key,position: bool):
	enemy_state.erase(key)
	enemy_state[key] = position

func get_enemy_engaged_position(key) -> Vector2:
	return enemy_engaged_position[key]

func set_enemy_engaged_position(key,position: Vector2):
	enemy_engaged_position.erase(key)
	enemy_engaged_position[key] = position

func get_enemy_current_position(key) -> Vector2:
	return enemy_current_position[key]

func set_enemy_current_position(key,position: Vector2):
	enemy_current_position.erase(key)
	enemy_current_position[key] = position

func get_enemy_initial_position(key) -> Vector2:
	return enemy_initial_position[key]

func set_enemy_initial_position(key,position: Vector2):
	enemy_initial_position.erase(key)
	enemy_initial_position[key] = position

