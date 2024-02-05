extends Node
class_name level_dao

var db = Database.get_db()

var question_access = questions_dao.new()
var terminal_access = terminal_dao.new()
var collectable_access = collectable_dao.new()

func get_level_id_by_name(level_name, game_id):
	var result = db.query("SELECT id FROM level WHERE name = '" + level_name + "' AND game_id = " + str(game_id) + ";")
	if result:
		return db.query_result[0]["id"]
	
	return null

func create_new_level(game_id, level_name, topic):
	var table_name = "level"
	var new_level = Dictionary()
	new_level["name"] = level_name
	new_level["game_id"] = game_id
	new_level["is_completed"] = false
	var result = db.insert_row(table_name, new_level)
	
	if not result:
		return false
	
	var level_id = self.get_level_id_by_name(level_name, game_id)
	
	var questions = question_access.select_random_questions(topic)
	
	for i in questions.size():
		print(level_id)
		print(questions[i]["id"])
		terminal_access.create_new_terminal(level_id, questions[i]["id"])
	
	collectable_access.create_new_collectable(level_id, "add_life")
	collectable_access.create_new_collectable(level_id, "add_life")	
	
	
