extends Control

@onready var username_line_edit = get_node("Panel/UsernameLineEdit")
@onready var company_code_line_edit = get_node("Panel/CompanyCodeLineEdit")
@onready var error_label = get_node("Panel/error_label")
@onready var error_label_username = get_node("Panel/error_label_username")
@onready var spinner = get_node("VBoxContainer/spinner")
@onready var spinner_text = get_node("VBoxContainer/spinner_text")

var scene_load_thread: Thread
var mutex = Mutex.new()
var username: String
var company_code: String

# Called when the node enters the scene tree for the first time.
func _ready():
	error_label.visible = false
	error_label_username.visible = false

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_start_btn_pressed():
	error_label.visible = false
	error_label_username.visible = false

	error_label.text = "Errore! Il codice inserito è inesistente"
	username = username_line_edit.text
	company_code = company_code_line_edit.text
	scene_load_thread = Thread.new()
	
	"""Username control block"""
	if username != '':
		"""Company code control block"""
		if company_code == '':
			error_label.text = "il codice della compagnia è obbligatorio"
			error_label.visible = true
		else :
			var request_body = {
				"publicKey": "testKey",
				"company": company_code
			}
			spinner.visible = true
			spinner_text.visible = true
			$HTTPRequest.request("https://tspr.ovh/api/quiz", ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify(request_body))
	else: 
		error_label_username.visible = true
	
func _async_load_main():
	mutex.lock()
	var main_menu = load("res://pages/main-menu/main-menu.tscn")
	get_tree().call_deferred('change_scene_to_packed', main_menu)
	mutex.unlock()
	
func _exit_tree():
	scene_load_thread.wait_to_finish()
	


func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if json["status"] == "400":
		if json["message"] == "Company does not exist":
			error_label.visible = true
			spinner.visible = false
			spinner_text.visible = false
	elif json["status"] == "200":
		Global.set_current_user(username, company_code)
		spinner_text.text = "Caricamento..."
		self._async_load_main()
		
		
