extends Node

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
	db = SQLite.new()
	db.path = db_name
	db.foreign_keys = true
	db.verbosity_level = SQLite.VERY_VERBOSE
	
	var thread = Thread.new()
	
	thread.start(__create_database)
	
	
func __create_database():
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
	else:
		print("database already exist")
		db.open_db()
		
	print("-----database ready-----")
	db.close_db()
	
func __tables_set_up():
	__user = Dictionary()
	__user["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__user["name"] = {"data_type": "string"}
	__user["company_code"] = {"data_type": "string"} 

	__player = Dictionary()
	__player["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__player["life"] = {"data_type": "int", "default": "3"}
	__player["damage_amount"] = {"data_type": "int", "default": "10"}

	__game = Dictionary()
	__game["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__game["palyer_id"] = {"data_type": "int", "foreign_key": __player.id, "not_null": true}
	__game["user_id"] = {"data_type": "int", "foreign_key": __user.id, "not_null": true}
	__game["last_completed_level"] = {"data_type": "int", "default": "0", "not_null": true}
	__game["playng_level"] = {"data_type": "int", "default": "0", "not_null": true}
	
	__level = Dictionary()
	__level["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__level["game_id"] = {"data_type": "int", "foreign_key": __game.id, "not_null": true}
	__level["is_completed"] = {"data_type": "bool", "defalut": "false", "not_null": true}
	
	__collectable = Dictionary()
	__collectable["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__collectable["level_id"] = {"data_type": "int", "foreign_key": __level.id, "not_null": true}
	__collectable["type"] = {"data_type": "string"}
	__collectable["is_reached"] = {"data_type": "bool", "default": "false", "not_null": true}
	
	__question = Dictionary()
	__question["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__question["type"] = {"data_type": "string"}
	__question["text"] = {"data_type": "string"}
	__question["company_code"] = {"data_type": "int", "foreign_key": __user.company_code, "not_null": true}
	
	__answare = Dictionary()
	__answare["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__answare["question_id"] = {"data_type": "int", "foreign_key": __question.id, "not_null": true}
	__answare["text"] = {"data_type": "string"}
	__answare["is_correct"] = {"data_type": "bool", "default": "false", "not_null": true}
	__answare["is_given"] = {"data_type": "bool", "default": "false", "not_null": true}
	
	__terminal = Dictionary()
	__terminal["id"] = {"data_type": "int", "primary_key": true, "auto_increment": true, "not_null": true}
	__terminal["level_id"] = {"data_type": "int", "foreign_key": __level.id, "not_null": true}
	__terminal["is_active"] = {"data_type": "bool", "default": "true", "not_null": true}
	__terminal["question_id"] = {"data_type": "int", "foreign_key": __question.id, "not_null": true}


