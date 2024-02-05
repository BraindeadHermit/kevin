extends Node

var mutex = Mutex.new()
var load_db: Thread

var db: SQLite
var db_name = "user://database/database"

"""Database Entities"""
var __user: Dictionary
var __player: Dictionary
var __game: Dictionary
var __level: Dictionary
var __collectable: Dictionary
var __question: Dictionary
var __answare: Dictionary
var __terminal: Dictionary



func _init():
	load_db = Thread.new()
	load_db.start(_async_create_db.bind())
	
func _async_create_db():
	mutex.lock()
	
	db = SQLite.new()
	db.path = db_name
	db.foreign_keys = true
	db.verbosity_level = SQLite.VERY_VERBOSE
	
	var dir_access = DirAccess.open("user://")
	if not dir_access.dir_exists_absolute("user://database"):
		print("creating database folder...")
		dir_access.make_dir("database")
	else:
		print("folder already present")
	
	if not FileAccess.file_exists("user://database/database.db"):
		print("creating database structure...")
		__tables_set_up()
		
		print("setting up the database...")
		db.open_db()
		db.create_table("user", __user)
		db.create_table("player", __player)
		db.create_table("game", __game)
		db.create_table("level", __level)
		db.create_table("collectable", __collectable)
		db.create_table("question", __question)
		db.create_table("answare", __answare)
		db.create_table("terminal", __terminal)
		
		self.create_questions()
	else:
		print("database already exist")
		db.open_db()
		
	print("-----database ready-----")
	
	mutex.unlock()
	
	
func __tables_set_up():
	__user = Dictionary()
	__user["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__user["name"] = {"data_type": "string"}
	__user["company_code"] = {"data_type": "string"} 

	__game = Dictionary()
	__game["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__game["user_id"] = {"data_type": "int", "foreign_key": __user.id, "not_null": true}
	__game["last_completed_level"] = {"data_type": "int", "default": "0", "not_null": true}
	__game["playng_level"] = {"data_type": "int", "default": "0", "not_null": true}
	
	__player = Dictionary()
	__player["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__player["game_id"] = {"data_type": "int", "foreign_key": __game.id, "not_null": true}
	__player["life"] = {"data_type": "int", "default": "3"}
	__player["damage_amount"] = {"data_type": "int", "default": "10"}
	
	__level = Dictionary()
	__level["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__level["name"] = {"data_type": "string", "not_null": true}
	__level["game_id"] = {"data_type": "int", "foreign_key": __game.id, "not_null": true}
	__level["is_completed"] = {"data_type": "bool", "defalut": "false", "not_null": true}
	
	__collectable = Dictionary()
	__collectable["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__collectable["level_id"] = {"data_type": "int", "foreign_key": __level.id, "not_null": true}
	__collectable["type"] = {"data_type": "string"}
	__collectable["is_reached"] = {"data_type": "bool", "default": "false", "not_null": true}
	
	__question = Dictionary()
	__question["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__question["category"] = {"data_type": "string"}
	__question["type"] = {"data_type": "string"}
	__question["text"] = {"data_type": "string"}
	__question["company_code"] = {"data_type": "int", "foreign_key": __user.company_code, "not_null": true}
	
	__answare = Dictionary()
	__answare["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__answare["question_id"] = {"data_type": "int", "foreign_key": __question.id, "not_null": true}
	__answare["text"] = {"data_type": "string"}
	__answare["is_correct"] = {"data_type": "bool", "default": "false", "not_null": true}
	
	__terminal = Dictionary()
	__terminal["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__terminal["level_id"] = {"data_type": "int", "foreign_key": __level.id, "not_null": true}
	__terminal["is_active"] = {"data_type": "bool", "default": "true", "not_null": true}
	__terminal["question_id"] = {"data_type": "int", "foreign_key": __question.id, "not_null": true}
	__terminal["is_given"] = {"data_type": "bool", "default": "false", "not_null": true}

func _exit_tree():
	self.load_db.wait_to_finish()
	print("closing  database...")
	db.close_db()
	
func get_db():
	return self.db

func create_questions():
	
	var question1 = Dictionary()
	question1["category"] = "malware"
	question1["type"] = "rm"
	question1["text"] = "domanda numero 1"
	question1["company_code"] = "CODE_01"

	var question2 = Dictionary()
	question2["category"] = "malware"
	question2["type"] = "rm"
	question2["text"] = "domanda numero 2"
	question2["company_code"] = "CODE_01"
	
	var question3 = Dictionary()
	question3["category"] = "malware"
	question3["type"] = "rm"
	question3["text"] = "domanda numero 3"
	question3["company_code"] = "CODE_01"
	
	var question4 = Dictionary()
	question4["category"] = "malware"
	question4["type"] = "rm"
	question4["text"] = "domanda numero 4"
	question4["company_code"] = "CODE_01"
	
	var question5 = Dictionary()
	question5["category"] = "malware"
	question5["type"] = "rm"
	question5["text"] = "domanda numero 5"
	question5["company_code"] = "CODE_01"
	
	var question6 = Dictionary()
	question6["category"] = "malware"
	question6["type"] = "rm"
	question6["text"] = "domanda numero 6"
	question6["company_code"] = "CODE_01"
	
	var question7 = Dictionary()
	question7["category"] = "malware"
	question7["type"] = "rm"
	question7["text"] = "domanda numero 7"
	question7["company_code"] = "CODE_01"
	
	"""RISPOTE DOMANDA 1"""
	var answare1_question1 = Dictionary()
	answare1_question1["question_id"] = 0
	answare1_question1["text"] = "risposta 1 domanda 1"
	answare1_question1["is_correct"] = false
	
	var answare2_question1 = Dictionary()
	answare2_question1["question_id"] = 0
	answare2_question1["text"] = "risposta 2 domanda 1"
	answare2_question1["is_correct"] = false
	
	var answare3_question1 = Dictionary()
	answare3_question1["question_id"] = 0
	answare3_question1["text"] = "risposta 3 domanda 1"
	answare3_question1["is_correct"] = true
	
	var answare4_question1 = Dictionary()
	answare4_question1["question_id"] = 0
	answare4_question1["text"] = "risposta 4 domanda 1"
	answare4_question1["is_correct"] = false
	
	"""RISPOTE DOMANDA 2"""
	var answare1_question2 = Dictionary()
	answare1_question2["question_id"] = 1
	answare1_question2["text"] = "risposta 1 domanda 2"
	answare1_question2["is_correct"] = false
	
	var answare2_question2 = Dictionary()
	answare2_question2["question_id"] = 1
	answare2_question2["text"] = "risposta 2 domanda 2"
	answare2_question2["is_correct"] = false
	
	var answare3_question2 = Dictionary()
	answare3_question2["question_id"] = 1
	answare3_question2["text"] = "risposta 3 domanda 2"
	answare3_question2["is_correct"] = true
	
	var answare4_question2 = Dictionary()
	answare4_question2["question_id"] = 1
	answare4_question2["text"] = "risposta 4 domanda 2"
	answare4_question2["is_correct"] = false
	
	"""RISPOTE DOMANDA 3"""
	var answare1_question3 = Dictionary()
	answare1_question3["question_id"] = 2
	answare1_question3["text"] = "risposta 1 domanda 3"
	answare1_question3["is_correct"] = false
	
	var answare2_question3 = Dictionary()
	answare2_question3["question_id"] = 2
	answare2_question3["text"] = "risposta 2 domanda 3"
	answare2_question3["is_correct"] = false
	
	var answare3_question3 = Dictionary()
	answare3_question3["question_id"] = 2
	answare3_question3["text"] = "risposta 3 domanda 3"
	answare3_question3["is_correct"] = true
	
	var answare4_question3 = Dictionary()
	answare4_question3["question_id"] = 2
	answare4_question3["text"] = "risposta 4 domanda 3"
	answare4_question3["is_correct"] = false

	"""RISPOTE DOMANDA 4"""
	var answare1_question4 = Dictionary()
	answare1_question4["question_id"] = 3
	answare1_question4["text"] = "risposta 1 domanda 4"
	answare1_question4["is_correct"] = false
	
	var answare2_question4 = Dictionary()
	answare2_question4["question_id"] = 3
	answare2_question4["text"] = "risposta 2 domanda 4"
	answare2_question4["is_correct"] = false
	
	var answare3_question4 = Dictionary()
	answare3_question4["question_id"] = 3
	answare3_question4["text"] = "risposta 3 domanda 4"
	answare3_question4["is_correct"] = true
	
	var answare4_question4 = Dictionary()
	answare4_question4["question_id"] = 3
	answare4_question4["text"] = "risposta 4 domanda 4"
	answare4_question4["is_correct"] = false
	
	"""RISPOTE DOMANDA 5"""
	var answare1_question5 = Dictionary()
	answare1_question5["question_id"] = 4
	answare1_question5["text"] = "risposta 1 domanda 5"
	answare1_question5["is_correct"] = false
	
	var answare2_question5 = Dictionary()
	answare2_question5["question_id"] = 4
	answare2_question5["text"] = "risposta 2 domanda 5"
	answare2_question5["is_correct"] = false
	
	var answare3_question5 = Dictionary()
	answare3_question5["question_id"] = 4
	answare3_question5["text"] = "risposta 3 domanda 5"
	answare3_question5["is_correct"] = true
	
	var answare4_question5 = Dictionary()
	answare4_question5["question_id"] = 4
	answare4_question5["text"] = "risposta 4 domanda 5"
	answare4_question5["is_correct"] = false
	
	"""RISPOTE DOMANDA 6"""
	var answare1_question6 = Dictionary()
	answare1_question6["question_id"] = 5
	answare1_question6["text"] = "risposta 1 domanda 6"
	answare1_question6["is_correct"] = false
	
	var answare2_question6 = Dictionary()
	answare2_question6["question_id"] = 5
	answare2_question6["text"] = "risposta 2 domanda 6"
	answare2_question6["is_correct"] = false
	
	var answare3_question6 = Dictionary()
	answare3_question6["question_id"] = 5
	answare3_question6["text"] = "risposta 3 domanda 6"
	answare3_question6["is_correct"] = true
	
	var answare4_question6 = Dictionary()
	answare4_question6["question_id"] = 5
	answare4_question6["text"] = "risposta 4 domanda 6"
	answare4_question6["is_correct"] = false
	
	"""RISPOTE DOMANDA 7"""
	var answare1_question7 = Dictionary()
	answare1_question7["question_id"] = 6
	answare1_question7["text"] = "risposta 1 domanda 7"
	answare1_question7["is_correct"] = false
	
	var answare2_question7 = Dictionary()
	answare2_question7["question_id"] = 6
	answare2_question7["text"] = "risposta 2 domanda 7"
	answare2_question7["is_correct"] = false
	
	var answare3_question7 = Dictionary()
	answare3_question7["question_id"] = 6
	answare3_question7["text"] = "risposta 3 domanda 7"
	answare3_question7["is_correct"] = true
	
	var answare4_question7 = Dictionary()
	answare4_question7["question_id"] = 6
	answare4_question7["text"] = "risposta 4 domanda 7"
	answare4_question7["is_correct"] = false
	
	db.insert_row("question", question1)
	db.insert_row("question", question2)
	db.insert_row("question", question3)
	db.insert_row("question", question4)
	db.insert_row("question", question5)
	db.insert_row("question", question6)
	db.insert_row("question", question7)
	
	db.insert_row("answare", answare1_question1)
	db.insert_row("answare", answare2_question1)
	db.insert_row("answare", answare3_question1)
	db.insert_row("answare", answare4_question1)

	db.insert_row("answare", answare1_question2)
	db.insert_row("answare", answare2_question2)
	db.insert_row("answare", answare3_question2)
	db.insert_row("answare", answare4_question2)
	
	db.insert_row("answare", answare1_question3)
	db.insert_row("answare", answare2_question3)
	db.insert_row("answare", answare3_question3)
	db.insert_row("answare", answare4_question3)
	
	db.insert_row("answare", answare1_question4)
	db.insert_row("answare", answare2_question4)
	db.insert_row("answare", answare3_question4)
	db.insert_row("answare", answare4_question4)
	
	db.insert_row("answare", answare1_question5)
	db.insert_row("answare", answare2_question5)
	db.insert_row("answare", answare3_question5)
	db.insert_row("answare", answare4_question5)
	
	db.insert_row("answare", answare1_question6)
	db.insert_row("answare", answare2_question6)
	db.insert_row("answare", answare3_question6)
	db.insert_row("answare", answare4_question6)
	
	db.insert_row("answare", answare1_question7)
	db.insert_row("answare", answare2_question7)
	db.insert_row("answare", answare3_question7)
	db.insert_row("answare", answare4_question7)
