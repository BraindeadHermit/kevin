extends Node
class_name to_send_dao

var db

func _init():
	self.db = Database.get_db()
	
func create_to_send(request_body):
	var to_send = Dictionary()
	
	to_send["qid"] = request_body["qid"]
	to_send["company"] = request_body["company"]
	to_send["platform"] = request_body["platform"]
	to_send["option_1"] = request_body["options"][0]
	to_send["option_2"] = request_body["options"][1]
	to_send["option_3"] = request_body["options"][2]
	to_send["option_4"] = request_body["options"][3]
	
	var result = await db.insert_row("to_send", to_send)
	
	return result

func get_to_send(qid):
	var result = await db.query("SELECT * FROM to_send WHERE qid = '" + qid + "';")
	
	if result:
		if db.query_result != []:
			return db.query_result[0]
		else:
			return null
		
	return null

func get_all_to_send():
	var result = await db.query("SELECT * FROM to_send;")
	
	if result:
		if db.query_result != []:
			return db.query_result
		
		return []
		
	return null

func delete_to_send(qid):
	var result = await db.query("DELETE FROM to_send WHERE qid = '" + qid + "';")
	
	return result
