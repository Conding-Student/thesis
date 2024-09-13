extends TextureRect

# A dictionary to store references to the UI elements.
onready var controls = {
	"add": $Control2/add_code,
	"code1": $Control2/add_code/code1,
	"dprocess1": $Control2/add_code/displaying_process,
	"output1": $Control2/add_code/output,
	"code2": $Control2/add_code/code2,
	"dprocess2": $Control2/add_code/displaying_process2,
	"output2": $Control2/add_code/output2,
	"AddRange": $Control2/add_range,
	"arcode1": $Control2/add_range/code3,
	"ardp1": $Control2/add_range/displaying_process3,
	"aroutput1": $Control2/add_range/output,
	"binarysearch": $Control2/binary_search,
	"bscode1": $Control2/binary_search/code3,
	"bsdp1": $Control2/binary_search/displaying_process3,
	"bsdp2": $Control2/binary_search/displaying_process4,
	"bsoutput": $Control2/binary_search/output,
	"clear": $Control2/clear,
	"ccode": $Control2/clear/code3,
	"cdp": $Control2/clear/displaying_process3,
	"contains": $Control2/contains,
	"concode": $Control2/contains/code3,
	"condp": $Control2/contains/displaying_process3,
	"condp2": $Control2/contains/displaying_process4,
	"condp3": $Control2/contains/displaying_process5,
	"conoutput": $Control2/contains/output,
	"count": $Control2/count,
	"countcode": $Control2/count/code3,
	"countdp1": $Control2/count/displaying_process3,
	"countdp2": $Control2/count/displaying_process4,
	"countdp3":$Control2/count/displaying_process5,
	"countoutput": $Control2/count/output,
	"find": $Control2/find,
	"findcode": $Control2/find/code3,
	"finddp1": $Control2/find/displaying_process3,
	"finddp2": $Control2/find/displaying_process4,
	"finddp3": $Control2/find/displaying_process5,
	"findoutput": $Control2/find/output,
	"foreach": $Control2/foreach,
	"forcode": $Control2/foreach/code1,
	"fordp": $Control2/foreach/displaying_process,
	"foroutput": $Control2/foreach/output,
	"insert": $Control2/insert,
	"insertcode": $Control2/insert/code3,
	"insertdp1": $Control2/insert/displaying_process3,
	"insertdp2": $Control2/insert/displaying_process4,
	"insertdp3": $Control2/insert/displaying_process5,
	"insertoutput": $Control2/insert/output,
	"insertrange":$Control2/insert_range,
	"insertrangecode": $Control2/insert_range/code3,
	"insertrangedp1": $Control2/insert_range/displaying_process3,
	"insertrangedp2":$Control2/insert_range/displaying_process4,
	"insertrangedp3": $Control2/insert_range/displaying_process5,
	"insertrangeoutput": $Control2/insert_range/output,
	"remove": $Control2/remove,
	"remcode": $Control2/remove/code3,
	"remdp1": $Control2/remove/displaying_process3,
	"remdp2": $Control2/remove/displaying_process4,
	"remdp3": $Control2/remove/displaying_process5,
	"remoutput": $Control2/remove/output,
	"removeat": $Control2/removeat,
	"rematcode": $Control2/removeat/code3,
	"rematdp1": $Control2/removeat/displaying_process3,
	"rematdp2": $Control2/removeat/displaying_process4,
	"rematdp3": $Control2/removeat/displaying_process5,
	"rematoutput": $Control2/removeat/output,
	"trimexcess": $Control2/trimexcess,
	"trimcode": $Control2/trimexcess/code3,
	"trimdp1": $Control2/trimexcess/displaying_process3,
	"trimdp2": $Control2/trimexcess/displaying_process4,
	"trimdp3": $Control2/trimexcess/displaying_process5,
	"trimoutput": $Control2/trimexcess/output,
	"items": $Control2/items,
	"itemscode": $Control2/items/code3,
	"itemsdp1": $Control2/items/displaying_process3,
	"itemsoutput": $Control2/items/output,
	"sort": $Control2/sort,
	"sortcode": $Control2/sort/code3,
	"sortdp1": $Control2/sort/displaying_process3,
	"sortdp2": $Control2/sort/displaying_process4,
	"sortdp3": $Control2/sort/displaying_process5,
	"sortoutput": $Control2/sort/output,
	"trueforall": $Control2/trueforall,
	"tfacode": $Control2/trueforall/code3,
	"tfadp1": $Control2/trueforall/displaying_process3,
	"tfadp2": $Control2/trueforall/displaying_process4,
	"tfadp3": $Control2/trueforall/displaying_process5,
	"tfaoutput": $Control2/trueforall/output
}

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent()
	hide()

# Called when the 'close' button is pressed.
func _on_close_pressed():
	hide()

# Show specific sections based on the button pressed.
func _on_Add_pressed():
	_set_visibility(["add"])

func _on_Add_Range_pressed():
	_set_visibility(["AddRange"])

func _on_Binary_Search_pressed():
	_set_visibility(["binarysearch"])

func _on_Clear_pressed():
	_set_visibility(["clear"])

func _on_Contains_pressed():
	_set_visibility(["contains"])

func _on_Foreach_pressed():
	_set_visibility(["foreach"])
	
func _on_Remove_pressed():
	_set_visibility(["remove"])

func _on_RemoveAt_pressed():
	_set_visibility(["removeat"])

func _on_TrimExcess_pressed():
	_set_visibility(["trimexcess"])

func _on_Count_pressed():
	_set_visibility(["count"])

func _on_Find_pressed():
	_set_visibility(["find"])

func _on_Insert_pressed():
	_set_visibility(["insert"])

func _on_Insert_Range_pressed():
	_set_visibility(["insertrange"])

func _on_Items_pressed():
	_set_visibility(["items"])
	
func _on_Sort_pressed():
	_set_visibility(["sort"])

func _on_TrueForAll_pressed():
	_set_visibility(["trueforall"])

# Helper function to set visibility of the sections.
func _set_visibility(visible_sections):
	for section in ["add", "AddRange", "binarysearch", "clear", "contains", "count","foreach","remove", "removeat", "trimexcess", "find","insert", "insertrange","items","sort","trueforall"]:
		controls[section].visible = section in visible_sections

# Helper function to set visibility of the nested controls.
func _update_visibility(control_names, visibility):
	for control_name in control_names:
		if control_name in controls:
			controls[control_name].visible = visibility

# Button press handlers for Add Code section.
func _on_AddMCode1_next_pressed():
	_update_visibility(["code1"], false)
	_update_visibility(["dprocess1"], true)

func _on_AddMDprocess_previous_pressed():
	_update_visibility(["code1"], true)
	_update_visibility(["dprocess1"], false)

func _on_AddMDprocess_next_pressed():
	_update_visibility(["dprocess1"], false)
	_update_visibility(["output1"], true)

func _on_AddMOutput_previous_pressed():
	_update_visibility(["output1"], false)
	_update_visibility(["dprocess1"], true)

func _on_AddMOutput_next_pressed():
	_update_visibility(["output1"], false)
	_update_visibility(["code2"], true)

func _on_AddMCode2_previous_pressed():
	_update_visibility(["code2"], false)
	_update_visibility(["output1"], true)

func _on_AddMCode2_next_pressed():
	_update_visibility(["code2"], false)
	_update_visibility(["dprocess2"], true)

func _on_AddMDprocess2_previous_pressed():
	_update_visibility(["dprocess2"], false)
	_update_visibility(["code2"], true)

func _on_AddMDprocess2_next_pressed():
	_update_visibility(["dprocess2"], false)
	_update_visibility(["output2"], true)

func _on_AddMOutput2_previous_pressed():
	_update_visibility(["output2"], false)
	_update_visibility(["dprocess2"], true)

# Button press handlers for Add Range section.
func _on_Addrange_code1_previous_pressed():
	_update_visibility(["arcode1"], false)
	_update_visibility(["ardp1"], true)

func _on_Addrange_dp1_previous_pressed():
	_update_visibility(["arcode1"], true)
	_update_visibility(["ardp1"], false)

func _on_Addrange_dp1_next_pressed():
	_update_visibility(["ardp1"], false)
	_update_visibility(["aroutput1"], true)

func _on_Addrange_output1_previous_pressed():
	_update_visibility(["aroutput1"], false)
	_update_visibility(["ardp1"], true)

# Button press handlers for Binary Search section.
func _on_binarysearch_code1_next_pressed():
	_update_visibility(["bscode1"], false)
	_update_visibility(["bsdp1"], true)

func _on_binarysearch_dp1_previous_pressed():
	_update_visibility(["bscode1"], true)
	_update_visibility(["bsdp1"], false)

func _on_binarysearch_dp1_next_pressed():
	_update_visibility(["bsdp1"], false)
	_update_visibility(["bsdp2"], true)

func _on_binarysearch_dp2_previous_pressed():
	_update_visibility(["bsdp2"], false)
	_update_visibility(["bsdp1"], true)

func _on_binarysearch_dp2_next_pressed():
	_update_visibility(["bsdp2"], false)
	_update_visibility(["bsoutput"], true)

func _on_binarysearch_output_previous_pressed():
	_update_visibility(["bsoutput"], false)
	_update_visibility(["bsdp2"], true)

# Button press handlers for Clear section.
func _on_clear_code_next_pressed():
	_update_visibility(["ccode"], false)
	_update_visibility(["cdp"], true)

func _on_clear_dp_previous_pressed():
	_update_visibility(["cdp"], false)
	_update_visibility(["ccode"], true)

# Button press handlers fro contain section.
func _on_contain_code1_next_pressed():
	_update_visibility(["concode"], false)
	_update_visibility(["condp"], true)

func _on_contains_condp_previous_pressed():
	_update_visibility(["concode"], true)
	_update_visibility(["condp"], false)

func _on_contains_condp_next_pressed():
	_update_visibility(["condp"], false)
	_update_visibility(["condp2"], true)

func _on_contains_dp2_previous_pressed():
	_update_visibility(["condp"], true)
	_update_visibility(["condp2"], false)

func _on_contains_dp2_next_pressed():
	_update_visibility(["condp2"], false)
	_update_visibility(["condp3"], true)

func _on_contains_dp3_previous_pressed():
	_update_visibility(["condp2"], true)
	_update_visibility(["condp3"], false)

func _on_contains_dp3_next_pressed():
	_update_visibility(["condp3"], false)
	_update_visibility(["conoutput"], true)

func _on_contains_conoutput_previous_pressed():
	_update_visibility(["condp3"], true)
	_update_visibility(["conoutput"], false)

# Button press handlers for count section.
func _on_count_code_next_pressed():
	_update_visibility(["countcode"], false)
	_update_visibility(["countdp1"], true)

func _on_count_dp1_previous_pressed():
	_update_visibility(["countcode"], true)
	_update_visibility(["countdp1"], false)

func _on_count_dp1_next_pressed():
	_update_visibility(["countdp1"], false)
	_update_visibility(["countdp2"], true)

func _on_count_dp2_previous_pressed():
	_update_visibility(["countdp1"], true)
	_update_visibility(["countdp2"], false)

func _on_count_dp2_next_pressed():
	_update_visibility(["countdp2"], false)
	_update_visibility(["countdp3"], true)

func _on_count_dp3_previous_pressed():
	_update_visibility(["countdp2"], true)
	_update_visibility(["countdp3"], false)

func _on_count_dp3_next_pressed():
	_update_visibility(["countdp3"], false)
	_update_visibility(["countoutput"], true)

func _on_count_output_previous_pressed():
	_update_visibility(["countdp3"], true)
	_update_visibility(["countoutput"], false)

# Button press handlers for Find section.
func _on_find_code_next_pressed():
	_update_visibility(["findcode"], false)
	_update_visibility(["finddp1"], true)

func _on_find_dp1_previous_pressed():
	_update_visibility(["findcode"], true)
	_update_visibility(["finddp1"], false)

func _on_find_dp1_next_pressed():
	_update_visibility(["finddp1"], false)
	_update_visibility(["finddp2"], true)

func _on_find_dp2_previous_pressed():
	_update_visibility(["finddp1"], true)
	_update_visibility(["finddp2"], false)

func _on_dinf_dp2_next_pressed():
	_update_visibility(["finddp2"], false)
	_update_visibility(["finddp3"], true)

func _on_find_dp3_previous_pressed():
	_update_visibility(["finddp2"], true)
	_update_visibility(["finddp3"], false)

func _on_find_dp3_next_pressed():
	_update_visibility(["finddp3"], false)
	_update_visibility(["findoutput"], true)

func _on_find_output_previous_pressed():
	_update_visibility(["finddp3"], true)
	_update_visibility(["findoutput"], false)

# Button press handlers for Foreach section.
func _on_foreach_code1_next_pressed():
	_update_visibility(["forcode"], false)
	_update_visibility(["fordp"], true)
	_update_visibility(["foroutput"], false)

func _on_foreach_dp_previous_pressed():
	_update_visibility(["forcode"], true)
	_update_visibility(["fordp"], false)
	_update_visibility(["foroutput"], false)

func _on_foreach_dp_next_pressed():
	_update_visibility(["fordp"], false)
	_update_visibility(["foroutput"], true)

func _on_foreach_output_previous_pressed():
	_update_visibility(["foroutput"], false)
	_update_visibility(["fordp"], true)

# Button press handlers from insert section.
func _on_inser_code_next_pressed():
	_update_visibility(["insertcode"], false)
	_update_visibility(["insertdp1"], true)

func _on_insert_dp1_previous_pressed():
	_update_visibility(["insertcode"], true)
	_update_visibility(["insertdp1"], false)

func _on_insert_dp1_next_pressed():
	_update_visibility(["insertdp1"], false)
	_update_visibility(["insertdp2"], true)

func _on_insert_dp2_previous_pressed():
	_update_visibility(["insertdp1"], true)
	_update_visibility(["insertdp2"], false)

func _on_insert_dp2_next_pressed():
	_update_visibility(["insertdp2"], false)
	_update_visibility(["insertdp3"], true)

func _on_insert_dp3_previous_pressed():
	_update_visibility(["insertdp2"], true)
	_update_visibility(["insertdp3"], false)

func _on_insert_dp3_next_pressed():
	_update_visibility(["insertdp3"], false)
	_update_visibility(["insertoutput"], true)

func _on_insert_output_previous_pressed():
	_update_visibility(["insertdp3"], true)
	_update_visibility(["insertoutput"], false)

# Button press handlers from insertrange section.
func _on_is_code_next_pressed():
	_update_visibility(["insertrangecode"], false)
	_update_visibility(["insertrangedp1"], true)
	
func _on_is_dp1_previous_pressed():
	_update_visibility(["insertrangecode"], true)
	_update_visibility(["insertrangedp1"], false)
	
func _on_is_dp1_next_pressed():
	_update_visibility(["insertrangedp1"], false)
	_update_visibility(["insertrangedp2"], true)
	
func _on_is_dp2_previous_pressed():
	_update_visibility(["insertrangedp1"], true)
	_update_visibility(["insertrangedp2"], false)
	
func _on_is_dp2_next_pressed():
	_update_visibility(["insertrangedp2"], false)
	_update_visibility(["insertrangedp3"], true)
	
func _on_is_dp3_previous_pressed():
	_update_visibility(["insertrangedp2"], true)
	_update_visibility(["insertrangedp3"], false)
	
func _on_is_dp3_next_pressed():
	_update_visibility(["insertrangedp3"], false)
	_update_visibility(["insertrangeoutput"], true)
	
func _on_is_output_previous_pressed():
	_update_visibility(["insertrangedp3"], true)
	_update_visibility(["insertrangeoutput"], false)

# Button press handlers from remove section.
func _on_remove_code_next_pressed():
	_update_visibility(["remcode"], false)
	_update_visibility(["remdp1"], true)

func _on_remove_dp1_previous_pressed():
	_update_visibility(["remcode"], true)
	_update_visibility(["remdp1"], false)

func _on_remove_dp1_next_pressed():
	_update_visibility(["remdp1"], false)
	_update_visibility(["remdp2"], true)

func _on_remove_dp2_previous_pressed():
	_update_visibility(["remdp1"], true)
	_update_visibility(["remdp2"], false)

func _on_remove_dp2_next_pressed():
	_update_visibility(["remdp2"], false)
	_update_visibility(["remdp3"], true)

func _on_remove_dp3_previous_pressed():
	_update_visibility(["remdp2"], true)
	_update_visibility(["remdp3"], false)

func _on_remove_dp3_next_pressed():
	_update_visibility(["remdp3"], false)
	_update_visibility(["remoutput"], true)

func _on_remove_output_previous_pressed():
	_update_visibility(["remdp3"], true)
	_update_visibility(["remoutput"], false)

# Button press handlers from removeat section.
func _on_removeat_code_next_pressed():
	_update_visibility(["rematcode"], false)
	_update_visibility(["rematdp1"], true)

func _on_removeat_rematdp1_previous_pressed():
	_update_visibility(["rematcode"], true)
	_update_visibility(["rematdp1"], false)
	
func _on_removeat_dp1_next_pressed():
	_update_visibility(["rematdp1"], false)
	_update_visibility(["rematdp2"], true)

func _on_removeat_dp2_previous_pressed():
	_update_visibility(["rematdp1"], true)
	_update_visibility(["rematdp2"], false)

func _on_removeat_dp2_next_pressed():
	_update_visibility(["rematdp2"], false)
	_update_visibility(["rematdp3"], true)

func _on_removeat_dp3_previous_pressed():
	_update_visibility(["rematdp2"], true)
	_update_visibility(["rematdp3"], false)

func _on_removeat_dp3_next_pressed():
	_update_visibility(["rematdp3"], false)
	_update_visibility(["rematoutput"], true)

func _on_removeat_output_previous_pressed():
	_update_visibility(["rematdp3"], true)
	_update_visibility(["rematoutput"], false)

# Button press handlers for trimexcess section.
func _on_trimexcess_code_next_pressed():
	_update_visibility(["trimcode"], false)
	_update_visibility(["trimdp1"], true)

func _on_trimexcess_dp1_previous_pressed():
	_update_visibility(["trimcode"], true)
	_update_visibility(["trimdp1"], false)

func _on_trimexcess_dp1_next_pressed():
	_update_visibility(["trimdp1"], false)
	_update_visibility(["trimdp2"], true)

func _on_trimexcess_dp2_previous_pressed():
	_update_visibility(["trimdp1"], true)
	_update_visibility(["trimdp2"], false)

func _on_trimexcess_dp2_next_pressed():
	_update_visibility(["trimdp2"], false)
	_update_visibility(["trimdp3"], true)

func _on_trimexcess_dp3_previous_pressed():
	_update_visibility(["trimdp2"], true)
	_update_visibility(["trimdp3"], false)

func _on_trimexcess_dp3_next_pressed():
	_update_visibility(["trimdp3"], false)
	_update_visibility(["trimoutput"], true)

func _on_trimexcess_output_previous_pressed():
	_update_visibility(["trimdp3"], true)
	_update_visibility(["trimoutput"], false)

# Button press handlers for items section.
func _on_items_code_next_pressed():
	_update_visibility(["itemscode"], false)
	_update_visibility(["itemsdp1"], true)

func _on_items_dp1_previous_pressed():
	_update_visibility(["itemscode"], true)
	_update_visibility(["itemsdp1"], false)

func _on_items_dp1_next_pressed():
	_update_visibility(["itemsdp1"], false)
	_update_visibility(["itemsoutput"], true)

func _on_items_output_previous_pressed():
	_update_visibility(["itemsdp1"], true)
	_update_visibility(["itemsoutput"], false)

# Button press handlers for sort section.
func _on_sort_code_next_pressed():
	_update_visibility(["sortcode"], false)
	_update_visibility(["sortdp1"], true)

func _on_sort_dp1_previous_pressed():
	_update_visibility(["sortcode"], true)
	_update_visibility(["sortdp1"], false)

func _on_sort_dp1_next_pressed():
	_update_visibility(["sortdp1"], false)
	_update_visibility(["sortdp2"], true)

func _on_sort_dp2_previous_pressed():
	_update_visibility(["sortdp1"], true)
	_update_visibility(["sortdp2"], false)

func _on_sort_dp2_next_pressed():
	_update_visibility(["sortdp2"], false)
	_update_visibility(["sortdp3"], true)

func _on_sort_dp3_previous_pressed():
	_update_visibility(["sortdp2"], true)
	_update_visibility(["sortdp3"], false)

func _on_sort_dp3_next_pressed():
	_update_visibility(["sortdp3"], false)
	_update_visibility(["sortoutput"], true)

func _on_sort_output_previous_pressed():
	_update_visibility(["sortdp3"], true)
	_update_visibility(["sortoutput"], false)

# Button press handlers for true for all section.
func _on_tfa_code_next_pressed():
	_update_visibility(["tfacode"], false)
	_update_visibility(["tfadp1"], true)

func _on_tfa_dp1_previous_pressed():
	_update_visibility(["tfacode"], true)
	_update_visibility(["tfadp1"], false)

func _on_tfa_dp1_next_pressed():
	_update_visibility(["tfadp1"], false)
	_update_visibility(["tfadp2"], true)

func _on_tfa_dp2_previous_pressed():
	_update_visibility(["tfadp1"], true)
	_update_visibility(["tfadp2"], false)

func _on_tfa_dp2_next_pressed():
	_update_visibility(["tfadp2"], false)
	_update_visibility(["tfadp3"], true)

func _on_tfa_dp3_previous_pressed():
	_update_visibility(["tfadp2"], true)
	_update_visibility(["tfadp3"], false)

func _on_tfa_dp3_next_pressed():
	_update_visibility(["tfadp3"], false)
	_update_visibility(["tfaoutput"], true)

func _on_tfa_output_previous_pressed():
	_update_visibility(["tfadp3"], true)
	_update_visibility(["tfaoutput"], false)
