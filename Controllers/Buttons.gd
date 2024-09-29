extends Node

onready var buttonattack = $BtnAttack
onready var buttonroll = $BtnRoll
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func hide_buttons():
	buttonattack.hide()
	buttonroll.hide()

func show_buttons():
	buttonattack.show()
	buttonroll.show()
