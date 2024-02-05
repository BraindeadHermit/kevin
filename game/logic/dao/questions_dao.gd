extends Node
class_name questions_dao

var db

func _init():
	self.db = Database.get_db()

func get_questions_numer_by_category(category):
	var respone = db.query("SELECT COUNT(id) FROM question WHERE category = '" + category + "';")
	
	if respone:
		return db.query_result[0]
	
	return 0

func get_questions_by_category(category):
	var result = db.query("SELECT * FROM question WHERE category = '" + category + "';")
	if result:
		return db.query_result
		
	return null
	
func select_random_questions(category):
	var rng = RandomNumberGenerator.new()
	var questions: Array = self.get_questions_by_category(category)
	
	var numbers = []
	
	while numbers.size() < 5:
		var number = rng.randi_range(0, questions.size() - 1)
		if not numbers.has(number):
			numbers.append(number)
			
	var selected_questions = []
	
	for i in numbers:
		selected_questions.append(questions[i])
		
	return selected_questions
	
func get_question_by_id(id):
	var result = db.query("SELECT * FROM question WHERE id = " + str(id) + ";")
	
	if result:
		return db.query_result[0]
		
	return null
