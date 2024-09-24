extends Label

func _process(delta):
	pass

func _ready():
	updating_label()


func updating_label():
	if Global2.is_badge_complete("badge1"):
		text = "Chapter1 U1 2 / 5"
		Global.set_current_level(text)	
	if Global2.is_badge_complete("badge2"):
		text = "Chapter1 U1 3 / 5"
		Global.set_current_level(text)
	if Global2.is_badge_complete("badge3"):
		text = "Chapter1 U1 4 / 5"
		Global.set_current_level(text)
	if Global2.is_badge_complete("badge4"):
		text = "Chapter1 U1 5 / 5"
		Global.set_current_level(text)
	if Global2.is_badge_complete("badge5"):
		text = "Chapter1 U2 1 / 5"
		Global.set_current_level(text)
	if Global2.is_badge_complete("badgel2s1"):
		text = "Chapter1 U2 2 / 5"
		Global.set_current_level(text)
