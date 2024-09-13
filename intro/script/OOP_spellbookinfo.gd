extends TextureRect

onready var controls = {
	"abstraction": $Control2/abstraction,
	"inheritance": $Control2/inheritance,
	"encapsulation":$Control2/encapsulation,
	"incode1": $Control2/inheritance/code1,
	"incode2": $Control2/inheritance/code2,
	"incode3": $Control2/inheritance/code3
	
	}


# Helper function to set visibility of the sections.
func _set_visibility(visible_sections):
	for section in ["abstraction","inheritance", "encapsulation"]:
		controls[section].visible = section in visible_sections

	
# Helper function to set visibility of the nested controls.
func _update_visibility(control_names, visibility):
	for control_name in control_names:
		if control_name in controls:
			controls[control_name].visible = visibility

func _on_Abstraction_pressed():
	_set_visibility(["abstraction"])


func _on_Inheritance_pressed():
	_set_visibility(["inheritance"])

func _on_Encapsulation_pressed():
	_set_visibility(["encapsulation"])

func _on_inheritance_code1_next_pressed():
	_update_visibility(["incode1"], false)
	_update_visibility(["incode2"], true)

func _on_inheritance_code2_previous_pressed():
	_update_visibility(["incode1"], true)
	_update_visibility(["incode2"], false)

func _on_inheritance_code3_next_pressed():
	_update_visibility(["incode2"], false)
	_update_visibility(["incode3"], true)

func _on_inheritance_code3_previous_pressed():
	_update_visibility(["incode3"], false)
	_update_visibility(["incode2"], true)



