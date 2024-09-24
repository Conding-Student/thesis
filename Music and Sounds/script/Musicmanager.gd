extends Node

onready var music_playing = $AudioStreamPlayer

var music_path: AudioStream = null  # Music path variable
var current_scene: String = "Scene1"  # Initialize the current scene as a string
var audio_bus: String = "Music"
var scene_music = {  # Define music for each scene
	"Scene1": "res://Music and Sounds/bg music/orphanageDay.wav",
	"Scene5": "res://Music and Sounds/bg music/newMusic.wav"
}

func _ready():
	if music_playing == null:
		if music_path == null:
			return  # Exit if no music path is set

		# Set up the initial music
		music_playing.stream = load(scene_music[current_scene]) as AudioStream
		music_playing.autoplay = true
		music_playing.bus = audio_bus

		# Add the AudioStreamPlayer as a child to the singleton node
		add_child(music_playing)

		# Connect the finished signal to restart the music if necessary
		music_playing.connect("finished", self, "_on_music_finished")

	else:
		if not music_playing.playing:
			music_playing.play()

#adjusting volume to low
func set_to_low():
	music_playing.volume_db = -20

func normal_volume():
	music_playing.volume_db = -15

# Function to handle scene change and update music accordingly
func change_scene(new_scene: String):
	if new_scene != current_scene:
		current_scene = new_scene
		if new_scene in scene_music:
			set_music_path(scene_music[new_scene])

# Function to set the music path and change the music
func set_music_path(path: String):
	music_path = load(path) as AudioStream
	if music_playing:
		music_playing.stop()  # Stop current music
		music_playing.stream = music_path
		music_playing.play()  # Play the new music

# Function to handle music finish and restart
func _on_music_finished():
	music_playing.play()  # Restart the music when it finishes

# Function to stop the music
func stop_music():
	if music_playing and music_playing.playing:
		music_playing.stop()

# Function to resume the music
func resume_music():
	if music_playing and not music_playing.playing:
		music_playing.play()
