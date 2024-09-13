extends Node

# List of loading screen scenes
var loading_screens = [
	"res://intro/loading_screens/loading_screen2.tscn",
	"res://intro/loading_screens/loading_screen3.tscn",
	"res://intro/loading_screens/progressbar.tscn",
	"res://intro/loading_screens/loading_screen4.tscn",
	"res://intro/loading_screens/loading_screen5.tscn"
]

# The scene that should be loaded after the loading screen
var target_scene = null
var loading_screen_instance = null

func _ready():
	randomize()  # Initialize the random number generator

func load_random_loading_screen(target):
	target_scene = target
	# Remove the current scene before showing the loading screen
	remove_current_scene()
	
	# Select a random loading screen
	var random_index = randi() % loading_screens.size()
	var random_loading_screen = loading_screens[random_index]

	# Load the random loading screen scene
	var loading_screen_scene = load(random_loading_screen)
	loading_screen_instance = loading_screen_scene.instance()
	get_tree().root.add_child(loading_screen_instance)
	
	# Optionally, set the loading screen to a group for easy removal later
	loading_screen_instance.add_to_group("loading_screens")

	# Pass the target scene to the loading screen instance
	if loading_screen_instance.has_method("set_target_scene"):
		loading_screen_instance.set_target_scene(target_scene)
	else:
		print("Warning: Loading screen instance does not have method 'set_target_scene'")

func remove_current_scene():
	# Get the current scene
	var current_scene = get_tree().current_scene
	if current_scene:
		# Remove the current scene from the tree
		current_scene.queue_free()
	
func load_target_scene():
	# Remove the loading screen before changing scenes
	if loading_screen_instance:
		loading_screen_instance.queue_free()  # Remove the loading screen

	# Change to the target scene
	var result = get_tree().change_scene(target_scene)
	if result != OK:
		print("Failed to load " + str(result))
