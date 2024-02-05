extends Node
class_name  terminal_dao

var db

func _init():
	db = Database.get_db()

func create_new_terminal(level_id: int, question_id: int):
	var terminal = Dictionary()
	terminal["level_id"] = level_id
	terminal["question_id"] = question_id
	terminal["is_active"] = true
	terminal["is_given"] = true
	
	var result = db.insert_row("terminal", terminal)
	
	return result
	
func get_terminals_by_level_id(level_id):
	var result = db.query("SELECT * FROM terminal WHERE level_id = " + str(level_id) + ";")
	
	if result:
		return db.query_result
	
