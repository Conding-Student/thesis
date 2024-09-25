extends Label

func _ready():
	updating_label()
	
func updating_label():
	# Create a mapping of badge names to corresponding text
	var badge_text_map = {
		"badge1": "Chapter1 U1 2 / 5",
		"badge2": "Chapter1 U1 3 / 5",
		"badge3": "Chapter1 U1 4 / 5",
		"badge4": "Chapter1 U1 5 / 5",
		"badge5": "Chapter1 U2 1 / 5",
		"badge6": "Chapter1 U2 2 / 5",
		"badge7": "Chapter1 U2 3 / 5",
		"badge8": "Chapter1 U2 4 / 5",
		"badge9": "Chapter1 U2 5 / 5",
		"badge10": "Chapter1 U3 1 / 5"
	}
	
	# Loop through the badge-text map and update the label for the first completed badge
	for badge_name in badge_text_map.keys():
		print(Global2.is_badge_complete(badge_name))
		if Global2.is_badge_complete(badge_name):
			text = badge_text_map[badge_name]
			Global.set_current_level(text)
			return  # Stop once the first completed badge is found
