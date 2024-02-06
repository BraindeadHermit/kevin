extends Node
class_name match_dao

var db = Database.get_db()

var user_access = user_dao.new()
var player_access = player_dao.new()

func create_new_match(username, company_code):
	
	var table_name = "game"
	var id = await user_access.get_user_id(username, company_code)
	
	var new_game = Dictionary()
	new_game["user_id"] = id
	new_game["last_completed_level"] = 0
	new_game["playng_level"] = 1
	await db.insert_row(table_name, new_game)
	
	var game_id = await get_last_game_id(id)
	
	await player_access.create_new_player(game_id)
	
	return game_id

func get_last_game_id(user_id):
	var res = await db.query("SELECT id FROM game WHERE game.user_id = " + str(user_id) + " ORDER BY id DESC LIMIT 1")
	if res:
		return db.query_result[0]["id"]
		
	return null
