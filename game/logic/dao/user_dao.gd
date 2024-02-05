extends Node
class_name user_dao

var db

func _init():
	db = Database.get_db()

func create_user(username, company_code):
	var table_name = "user"
	var new_user = Dictionary()
	new_user["name"] = username
	new_user["company_code"] = company_code 
	db.insert_row(table_name, new_user)
		
func get_user_id(username, company_code):
	var res = db.query("SELECT id FROM user WHERE user.name = '" + username + "' AND user.company_code = '" + company_code + "'")
	
	if res:
		return db.query_result[0]["id"]
		
	return null
	
