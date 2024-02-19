extends Node
class_name level_dao

var db = Database.get_db()

var question_access = questions_dao.new()
var terminal_access = terminal_dao.new()
var collectable_access = collectable_dao.new()

func get_level_id_by_name(level_name, game_id):
	var result = await db.query("SELECT id FROM level WHERE name = '" + level_name + "' AND game_id = " + str(game_id) + ";")
	if result:
		if db.query_result != []:
			return db.query_result[0]["id"]
		else:
			return -1
	
	return null

func create_new_level(game_id, level_name, topic):
	var table_name = "level"
	var new_level = Dictionary()
	new_level["name"] = level_name
	new_level["game_id"] = game_id
	new_level["is_completed"] = false
	var result = await db.insert_row(table_name, new_level)
	
	if not result:
		return -1
	
	var level_id = await self.get_level_id_by_name(level_name, game_id)
	
	var questions = await question_access.select_random_questions(topic)
	
	for i in questions.size():
		await terminal_access.create_new_terminal(level_id, questions[i]["qid"])
	
	await collectable_access.create_new_collectable(level_id, "add_life")
	await collectable_access.create_new_collectable(level_id, "add_life")
	
	return level_id
	
func get_answered_questions_number(level_id):
	var result = await db.query("SELECT COUNT(id) FROM terminal WHERE level_id = " +  str(level_id ) + " AND is_given = true;")
	
	if result:
		return db.query_result[0]["COUNT(id)"]
		
func get_level_by_id(level_id):
	var result = await db.query("SELECT * FROM level WHERE id = " + str(level_id) + ";")
	
	if result:
		return db.query_result[0]
	
	return null

func set_level_is_completed(level_id):
	var result = await db.query("UPDATE level SET is_completed = true WHERE id = " + str(level_id) + ";")
	
	return result
	
func is_level_completed(level_name, match_id):
	var result = await db.query("SELECT is_completed FROM level WHERE name = '" + level_name + "' AND game_id = " + str(match_id) + ";")
	
	if result:
		print(db.query_result)
		return db.query_result[0]["is_completed"]
		
	return null
	
func delete_level_by_match_id(level_name, match_id):
	var result = await db.query("SELECT id FROM level WHERE name = '" + level_name + "' AND game_id = " + str(match_id) + ";")
	var level_id
	if result:
		print(db.query_result)
		level_id = db.query_result[0]["id"]
	
	await db.query("DELETE FROM level WHERE id = " + str(level_id) + ";")
	await terminal_access.delate_terminal_by_level_id(level_id)
	await collectable_access.delete_collectable_by_level_id(level_id)
	
	return result
