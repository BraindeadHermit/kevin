extends Node
class_name questions_dao

var db

func _init():
	self.db = Database.get_db()

func get_questions_numer_by_category(category):
	var respone = await db.query("SELECT COUNT(qid) FROM question WHERE category = '" + category + "';")
	
	if respone:
		return db.query_result[0]["COUNT(qid)"]
	
	return 0

func get_questions_by_category(category):
	var result = await db.query("SELECT * FROM question WHERE category = '" + category + "';")
	if result:
		return db.query_result
		
	return null
	
func select_random_questions(category):
	var rng = RandomNumberGenerator.new()
	var questions: Array = await self.get_questions_by_category(category)
	
	var numbers = []
	
	while numbers.size() < 5:
		var number = rng.randi_range(0, questions.size() - 1)
		if not numbers.has(number):
			numbers.append(number)
			
	var selected_questions = []
	
	for i in numbers:
		selected_questions.append(questions[i])
		
	return selected_questions
	
func get_question_by_qid(qid):
	var result = await db.query("SELECT * FROM question WHERE qid = '" + qid + "';")
	
	if result:
		if db.query_result != []:
			return db.query_result[0]
		else:
			return null
		
	return null
	
func create_question(question):
	var result = await db.insert_row("question", question)
	
	return result
	
func get_all_questions_qid():
	var result = await db.query("SELECT qid FROM question;")
	
	if result:
		if db.query_result != []:
			return db.query_result
		
		return []
		
	return null

func delete_question(qid):
	var result = await db.query("DELETE FROM question WHERE qid = '" + qid + "';")
	
	return result
