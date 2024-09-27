extends Node

# Helper function to convert Vector2 to an array
func vector2_to_array(v: Vector2) -> Array:
	return [v.x, v.y]

# Helper function to convert a dictionary of Vector2 to arrays
func convert_positions_to_arrays(positions: Dictionary) -> Dictionary:
	var converted = {}
	for key in positions:
		converted[key] = vector2_to_array(positions[key])
	return converted

# Helper function to handle file operations
func save_to_file(filename: String, data: Dictionary) -> void:
	var file = File.new()
	var error = file.open(filename, File.WRITE)
	if error == OK:
		var save_string = JSON.print(data)
		file.store_string(save_string)
		file.close()
	else:
		print("Failed to open file for writing")

# Helper function to load data from a file
func load_from_file(filename: String) -> Dictionary:
	var file = File.new()
	var error = file.open(filename, File.READ)
	if error == OK:
		var content = file.get_as_text()
		file.close()
		return JSON.parse(content).result
	else:
		print("Failed to open file for reading")
		return {}

# Save game data to a file
func save_game() -> void:
	save_data("user://file.txt")

# Autosave game data to a file
func auto_save_file() -> void:
	save_data("user://autosave.txt")

# Consolidated function to save game data
func save_data(filename: String) -> void:
	
	var save_data = {
		"players_health": PlayerStats.health,
		"map": Global.get_map(),
		"current_level": Global.get_current_level(),
		"save_triggered": Global.save_triggered,
		"from_level": Global.from_level,
		"player_current_position": vector2_to_array(Global.get_player_current_position()),
		"player_initial_position": vector2_to_array(Global.player_initial_position),
		"player_position_engaged": vector2_to_array(Global.player_position_engaged),
		"player_after_door_position": vector2_to_array(Global.player_after_door_position),
		"player_position_retain": Global.player_position_retain,
		"load_position": Global.load_game_position,
		"enemy_current_position": convert_positions_to_arrays(Global.enemy_current_position),
		"enemy_initial_position": convert_positions_to_arrays(Global.enemy_initial_position),
		"enemy_engaged_position": convert_positions_to_arrays(Global.enemy_engaged_position),
		"enemy_state": Global.enemy_state,
		"enemy_defeated": Global.enemy_defeated,
		"dialogue_start_tutorial": Global.dialogue_start_tutorial,
		#"explore_town": Global2.explore_town,
		#"manor_guard": Global2.manor_guard,
		#"lady_on_townsquare": Global2.lady_on_townsquare,
		#"paladin_mage_guild": Global2.paladin_mage_guild,
		#"after_quiz": Global2.after_quiz,
		"bat_states": Global.bat_states,
		"door_states": Global.door_states,
		"dialogue_states": Global.dialogue_states,
		"manor_quest": Global2.state
	}
	Dialogic.save("slot1")
	# Collect badge data for saving
	for badge_name in Global2.badges_complete.keys():
		save_data[badge_name] = Global2.badges_complete[badge_name]
	
	save_to_file(filename, save_data)



# Load game data from a file
func load_game() -> void:
	var loaded_data = load_from_file("user://file.txt")

	if loaded_data:
		apply_loaded_data(loaded_data)

# Load game data from autosave file
func load_game_auto() ->void:
	var loaded_data = load_from_file("user://autosave.txt")

	if loaded_data:
		apply_loaded_data(loaded_data)


func apply_loaded_data(loaded_data: Dictionary) -> void:
	# Load general game state
	Global.save_triggered = loaded_data.get("save_triggered", false)
	Global.from_level = loaded_data.get("from_level", "")
	PlayerStats.health = loaded_data.get("players_health", 100)  # Assuming a default value
	Dialogic.load("slot1")
	# Load location and state variables
	#Global2.explore_town = int(loaded_data.get("explore_town", 0))
	#Global2.paladin_mage_guild = int(loaded_data.get("paladin_mage_guild", 0))
	#Global2.lady_on_townsquare = int(loaded_data.get("lady_on_townsquare", 0))
	#Global2.manor_guard = int(loaded_data.get("manor_guard", 0))
	#Global2.after_quiz = int(loaded_data.get("after_quiz", 0))

	# Set dialogic variables
	#Dialogic.set_variable("explore_town", Global2.explore_town)
	#Dialogic.set_variable("paladin", Global2.paladin_mage_guild)
	#Dialogic.set_variable("citizen", Global2.lady_on_townsquare)
	#Dialogic.set_variable("manor_guard", Global2.manor_guard)
	#Dialogic.set_variable("after_quiz", Global2.after_quiz)

	# Load player positions
	Global.set_player_current_position(Vector2(loaded_data.get("player_current_position", [0, 0])[0], loaded_data.get("player_current_position", [0, 0])[1]))
	Global.set_player_initial_position(Vector2(loaded_data.get("player_initial_position", [0, 0])[0], loaded_data.get("player_initial_position", [0, 0])[1]))
	Global.set_player_position_engaged(Vector2(loaded_data.get("player_position_engaged", [0, 0])[0], loaded_data.get("player_position_engaged", [0, 0])[1]))
	Global.set_player_after_door_position(Vector2(loaded_data.get("player_after_door_position", [0, 0])[0], loaded_data.get("player_after_door_position", [0, 0])[1]))
	Global.player_position_retain = loaded_data.get("player_position_retain", false)
	Global.load_game_position = loaded_data.get("load_position", Vector2(0, 0))

	# Load enemy positions
	if "enemy_current_position" in loaded_data:
		for enemy in loaded_data["enemy_current_position"]:
			Global.set_enemy_current_position(enemy, Vector2(loaded_data["enemy_current_position"][enemy][0], loaded_data["enemy_current_position"][enemy][1]))

	if "enemy_initial_position" in loaded_data:
		for enemy in loaded_data["enemy_initial_position"]:
			Global.set_enemy_initial_position(enemy, Vector2(loaded_data["enemy_initial_position"][enemy][0], loaded_data["enemy_initial_position"][enemy][1]))

	if "enemy_engaged_position" in loaded_data:
		for enemy in loaded_data["enemy_engaged_position"]:
			Global.set_enemy_engaged_position(enemy, Vector2(loaded_data["enemy_engaged_position"][enemy][0], loaded_data["enemy_engaged_position"][enemy][1]))

	# Load badges
	for badge_name in Global2.badges_complete.keys():
		if badge_name in loaded_data:
			Global2.badges_complete[badge_name] = loaded_data[badge_name]

	# Load enemy state and map
	Global.enemy_state = loaded_data.get("enemy_state", {})
	Global.enemy_defeated = loaded_data.get("enemy_defeated", false)
	Global.set_map(loaded_data.get("map", ""))
	Global.set_current_level(loaded_data.get("current_level", 1))
	Global.door_states = loaded_data.get("door_states", {})
	Global.dialogue_states = loaded_data.get("dialogue_states", {})

	#quest
	Global2.state = loaded_data.get("manor_quest")

	# Load bat states if available
	if "bat_states" in loaded_data:
		Global.bat_states = loaded_data["bat_states"]


# Function to check if "save_triggered" is set in file.txt
func check_save_triggered_in_file() -> bool:
	var loaded_data = load_from_file("user://file.txt")
	if loaded_data and "save_triggered" in loaded_data:
		return loaded_data["save_triggered"]
	return false

# Function to check if "current_level" is set in file.txt
func check_current_level_in_file() -> String:
	var loaded_data = load_from_file("user://file.txt")
	if loaded_data and "current_level" in loaded_data:
		return str(loaded_data["current_level"])  # Ensure the return value is a String
	return ""  # Return an empty string or a default value if "current_level" is not found

# Function to check if "save_triggered" is set in file.txt
func check_save_triggered_in_autosave() -> bool:
	var loaded_data = load_from_file("user://autosave.txt")
	if loaded_data and "save_triggered" in loaded_data:
		return loaded_data["save_triggered"]
	return false

# Load current game level from file
func load_game_button() -> void:
	var loaded_data = load_from_file("user://file.txt")
	if loaded_data:
		Global.set_current_level(loaded_data["current_level"])

func check_if_loaded_data() -> void:
	var loaded_data = load_from_file("user://file.txt")
	var loaded_data2 = load_from_file("user://autosave.txt")

	var save_triggered_file = false
	var save_triggered_autosave = false

	if loaded_data and "save_triggered" in loaded_data and loaded_data["save_triggered"]:
		save_triggered_file = true

	if loaded_data2 and "save_triggered" in loaded_data2 and loaded_data2["save_triggered"]:
		save_triggered_autosave = true

	if save_triggered_file or save_triggered_autosave:
		Global.save_triggered = true
		if save_triggered_file:
			if "badges_complete" in loaded_data:
				Global2.badges_complete = loaded_data["badges_complete"]
			else:
				print("Key 'badges_complete' not found in loaded_data.")
		if save_triggered_autosave:
			if "badges_complete" in loaded_data:
				Global2.badges_complete = loaded_data["badges_complete"]
			else:
				print("Key 'badges_complete' not found in loaded_data.")
			pass
		print("Save triggered in at least one file, data loaded successfully.")
	else:
		Global.save_triggered = false
		print("No valid save data found or file loading error.")




