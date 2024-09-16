extends Panel

onready var stage1 = $TextureRect
onready var stage2 = $TextureRect2
onready var timer = $Timer
onready var animation = $AnimationPlayer
onready var save_n_load = $saving_file
var current_stage = 0

func _ready():
	# Initialize stage visibility
	stage1.visible = false
	stage2.visible = false
	
	if not timer.is_connected("timeout", self, "_on_Timer_timeout"):
		timer.connect("timeout", self, "_on_Timer_timeout")
	
func _process(delta: float) -> void:
	if Global2.stage1_complete:
		show_stage(1)
		Global2.stage1_complete = false
	if Global2.stage2_complete:
		show_stage(2)
		Global2.stage2_complete = false
		#pass

func show_stage(stage):
	if stage == 1:
		if not stage1.visible:
			stage1.visible = true
			stage2.visible = false
			current_stage = 1
			PlayerStats.health = 5
			var text = "Chapter1 U1 2 / 5"
			Global.set_current_level(text)
			Global.save_triggered = true
			save_n_load.auto_save_file()
			timer.start(3)
	elif stage == 2:
		if not stage2.visible:
			stage1.visible = false
			stage2.visible = true
			current_stage = 2
			PlayerStats.health = 5
			Global.save_triggered = true
			save_n_load.auto_save_file()
			timer.start(3)

func _on_Timer_timeout():
	animation.play("fade_out")
	if current_stage == 1:
		
		stage1.visible = false
	elif current_stage == 2:
		
		stage2.visible = false
