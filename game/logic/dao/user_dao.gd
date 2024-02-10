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
	await db.insert_row(table_name, new_user)
		
func get_user_id(username, company_code):
	var res = await db.query("SELECT id FROM user WHERE user.name = '" + username + "' AND user.company_code = '" + company_code + "'")
	
	if res:
		if db.query_result == []:
			return -1
		else:
			return db.query_result[0]["id"]
		
	return null
	
