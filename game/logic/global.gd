extends  Node
class_name  auth_info 

var _username: String = ""
var _company_code: String = ""

func init(username: String, company_code: String):
	_username = username
	_company_code = company_code
	
func get_username():
	return _username
	
func get_company_code():
	return _company_code
	
func set_username(value):
	_username = value
	
func set_company_code(value):
	_company_code = value
