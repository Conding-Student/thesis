extends Node

onready var saving_file = $saving_file
func _ready():
	pass
	#var new_dialog = Dialogic.start('child1')
	#add_child(new_dialog)
	#new_dialog.connect("timeline_end", self, "after_dialog")

func after_dialog(timelinename):
	saving_file.load_game()
	
	#if Global.get_map() != "":
		#SceneTransition.change_scene(Global.get_map())
	#else:
		#SceneTransition.change_scene("res://World/room/orphanage_room.tscn")


