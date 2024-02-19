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
	
func get_collectables_by_level_id(level_id):
	var result = await db.query("SELECT * FROM collectable WHERE level_id = " + str(level_id) + ";")
	
	if result:
		return db.query_result
		
	return null;
	
func set_is_reached(id, level_id):
	var result = await db.query("UPDATE collectable SET is_reached = true WHERE id = " + str(id) + " AND level_id = " + str(level_id) + ";")
	return result
