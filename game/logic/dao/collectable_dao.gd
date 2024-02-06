extends Node
class_name collectable_dao

var db = Database.get_db()
var question_access = questions_dao.new()

func create_new_collectable(level_id, type):
	
	var collectable = Dictionary();
	collectable["level_id"] = level_id
	collectable["type"] = type
	var result = await db.insert_row("collectable", collectable)
	
	return result
