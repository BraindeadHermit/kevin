extends Node
class_name answare_dao

var db

func _init():
	self.db = Database.get_db()

func get_answares_by_question_id(id):
	var result = await db.query("SELECT * FROM answare WHERE question_id = " + str(id) + ";")
	
	if result:
		return db.query_result
		
	return null
