extends Control

var username_line_edit = null
var company_code_line_edit = null
var error_label = null
var error_label_username = null


# Called when the node enters the scene tree for the first time.
func _ready():
	username_line_edit = get_node("VBoxContainer2/VBoxContainer/UsernameLineEdit")
	company_code_line_edit = get_node("VBoxContainer2/VBoxContainer2/CompanyCodeLineEdit")
	error_label = get_node("VBoxContainer2/VBoxContainer2/error_label")
	error_label_username = get_node("VBoxContainer2/VBoxContainer/error_label_username")
	
	error_label.visible = false
	error_label_username.visible = false


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_start_btn_pressed():
	error_label.visible = false
	error_label_username.visible = false

	error_label.text = "Errore! Il codice inserito è inesistente"
	var username = username_line_edit.text
	var company_code = company_code_line_edit.text
	
	"""Username control block"""
	if username != '':
		"""Company code control block"""
		if company_code == 'ciao':
			get_tree().change_scene_to_file("res://pages/main-menu/main-menu.tscn")
		elif company_code == '':
			error_label.text = "il codice della compagnia è obbligatorio"
			error_label.visible = true
		else: 
			error_label.visible = true
	else: 
		error_label_username.visible = true
