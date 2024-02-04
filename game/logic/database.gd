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

func _exit_tree():
	print("closing  database...")
	db.close_db()

func create_new_match(username, company_code):
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	
	var table_name = "game"
	var id = self.get_user_id(username, company_code)
	
	var new_game = Dictionary()
	new_game["user_id"] = id
	new_game["last_completed_level"] = 0
	new_game["playng_level"] = 1
	db.insert_row(table_name, new_game)
	
	var game_id = get_last_game_id(id)
	
	var new_player = Dictionary()
	new_player["game_id"] = get_last_game_id(id)
	new_player["life"] = 3
	new_player["damage_amount"] = 10
	db.insert_row("player", new_player)
	
	create_level(game_id)
	
	db.close_db()
	
	return game_id
	
	
	
func create_user(username, company_code):
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	
	var table_name = "user"
	var new_user = Dictionary()
	new_user["name"] = username
	new_user["company_code"] = company_code 
	db.insert_row(table_name, new_user)
	
	db.close_db()
	
func get_user_id(username, company_code):
	var res = db.query("SELECT id FROM user WHERE user.name = '" + username + "' AND user.company_code = '" + company_code + "'")
	if res:
		return db.query_result[0]["id"]
		
	return null
	
func get_last_game_id(user_id):
	var res = db.query("SELECT id FROM game WHERE game.user_id = " + str(user_id) + " ORDER BY id DESC LIMIT 1")
	if res:
		return db.query_result[0]["id"]
		
	return null
	
func create_level(game_id):
	var table_name = "level"
	var new_level = Dictionary()
	new_level["game_id"] = game_id
	new_level["is_completed"] = false
	db.insert_row(table_name, new_level)
	
func get_player_by_match_id(match_id):
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	
	var res = db.query("SELECT * FROM player WHERE player.game_id = " + str(match_id) + ";")
	if res:
		db.close_db()
		return db.query_result[0]
		
	db.close_db()
	return null
	
func set_player_lifes(lifes, game_id):
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	
	var res = db.query("UPDATE player SET life = " + str(lifes) + " WHERE game_id = " + str(game_id) + ";")
	
	if res:
		print("updated")
		
	db.close_db()
