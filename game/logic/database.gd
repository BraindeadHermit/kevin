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
var __to_send: Dictionary



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
		db.create_table("to_send", __to_send)
		
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
	__question["qid"] = {"data_type": "string", "primary_key": true, "auto_increment": false, "not_null": true}
	__question["category"] = {"data_type": "string"}
	__question["text"] = {"data_type": "string"}
	__question["company_code"] = {"data_type": "int", "foreign_key": __user.company_code, "not_null": true}
	
	__answare = Dictionary()
	__answare["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__answare["question_qid"] = {"data_type": "int", "foreign_key": __question.qid, "not_null": true}
	__answare["text"] = {"data_type": "string"}
	__answare["is_correct"] = {"data_type": "bool", "default": "false", "not_null": true}
	
	__terminal = Dictionary()
	__terminal["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__terminal["level_id"] = {"data_type": "int", "foreign_key": __level.id, "not_null": true}
	__terminal["is_active"] = {"data_type": "bool", "default": "true", "not_null": true}
	__terminal["question_qid"] = {"data_type": "string", "foreign_key": __question.qid, "not_null": true}
	__terminal["is_given"] = {"data_type": "bool", "default": "false", "not_null": true}
	__terminal["given_answer"] = {"data_type": "int", "default": "0", "not_null": true}
	
	__to_send = Dictionary()
	__to_send["qid"] = {"data_type": "string", "primary_key": true, "auto_increment": false, "not_null": true}
	__to_send["company"] = {"data_type": "string"}
	__to_send["platform"] = {"data_type": "string"}
	__to_send["option_1"] = {"data_type": "bool", "default": "false", "not_null": true}
	__to_send["option_2"] = {"data_type": "bool", "default": "false", "not_null": true}
	__to_send["option_3"] = {"data_type": "bool", "default": "false", "not_null": true}
	__to_send["option_4"] = {"data_type": "bool", "default": "false", "not_null": true}
	

func _exit_tree():
	self.load_db.wait_to_finish()
	print("closing  database...")
	db.close_db()
	
func get_db():
	return self.db
