extends Node
class_name  terminal_dao

var db

func _init():
	db = Database.get_db()

func create_new_terminal(level_id, question_qid):
	var terminal = Dictionary()
	terminal["level_id"] = level_id
	terminal["question_qid"] = question_qid
	
	var result = await db.insert_row("terminal", terminal)
	
	return result
	
func get_terminals_by_level_id(level_id):
	var result = await db.query("SELECT * FROM terminal WHERE level_id = " + str(level_id) + ";")
	
	if result:
		print(db.query_result)
		return db.query_result
	
func set_is_given(terminal_id):
	var result = await db.query("UPDATE terminal SET is_given = true WHERE id = " + str(terminal_id) + ";")
	
	return result
	
func set_given_answer(terminal_id, given_answer):
	var result = await db.query("UPDATE terminal SET given_answer = " + str(given_answer) + " WHERE id = " + str(terminal_id) + ";")
	
	return result
