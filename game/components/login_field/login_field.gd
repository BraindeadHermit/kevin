extends CanvasLayer

var company_code = ""
var error_label = null

func _on_ready():
	error_label = get_node("Control/Label2")
	error_label.visible = false
	
func _on_line_edit_text_changed(new_text):
	company_code = new_text

func _on_start_pressed():
	error_label.visible = false
	if company_code == "":
		error_label.text = "Devi inserire il codice dell'azienda per iniziare"
		error_label.visible = true
		return
		
	if company_code == "ciao":
		"""check the company code"""
		get_tree().change_scene_to_file("res://main.tscn")
	else:
		error_label.text = "Il codice inserito non esiste"
		error_label.visible = true

func _on_quit_pressed():
	get_tree().quit()

