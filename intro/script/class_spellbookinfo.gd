extends TextureRect

onready var class_info = $Control2/class
onready var object_info = $Control2/object
func _on_Create_class_pressed():
	class_info.visible = true
	object_info.visible = false

func _on_create_object_pressed():
	class_info.visible = false
	object_info.visible = true

func _on_close_pressed():
	hide()
