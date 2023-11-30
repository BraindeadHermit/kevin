extends Control

@onready var username_line_edit = get_node("VBoxContainer2/VBoxContainer/UsernameLineEdit")
@onready var company_code_line_edit = get_node("VBoxContainer2/VBoxContainer2/CompanyCodeLineEdit")
@onready var error_label = get_node("VBoxContainer2/VBoxContainer2/error_label")
@onready var error_label_username = get_node("VBoxContainer2/VBoxContainer/error_label_username")
@onready var spinner = get_node("VBoxContainer/spinner")
@onready var spinner_text = get_node("VBoxContainer/spinner_text")


# Called when the node enters the scene tree for the first time.
func _ready():
	error_label.visible = false
	error_label_username.visible = false

func login(code):
	spinner.visible = true
	spinner_text.visible = true
	if code == 'ciao':
		return true
	else: 
		return false

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
		if login(company_code):
			spinner_text.text = "Caricamento..."
			"""get_tree().change_scene_to_file("res://pages/main-menu/main-menu.tscn")"""
		elif company_code == '':
			error_label.text = "il codice della compagnia è obbligatorio"
			error_label.visible = true
		else: 
			error_label.visible = true
	else: 
		error_label_username.visible = true
