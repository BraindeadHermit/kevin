extends  Node
class_name  auth_info 


var _username: String = ""
var _company_code: String = ""
var _current_match_id: int
var user_access

func _init():
	user_access = user_dao.new()

func set_current_user(username: String, company_code: String):
	_username = username
	_company_code = company_code
	var user_id = user_access.get_user_id(username, company_code)
	if user_id == -1:
		user_access.create_user(self._username, self._company_code)
	
func get_username():
	return _username
	
func get_company_code():
	return _company_code
	
func set_username(value):
	_username = value
	
func set_company_code(value):
	_company_code = value

func set_current_match_id(id):
	self._current_match_id = id
	
func get_current_match_id():
	return self._current_match_id
