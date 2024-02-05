extends Node
class_name  player_dao

var db = Database.get_db()

func create_new_player(game_id):
	var new_player = Dictionary()
	new_player["game_id"] = game_id
	new_player["life"] = 3
	new_player["damage_amount"] = 10
	var result = db.insert_row("player", new_player)
	
	return result
	
func get_player_by_match_id(match_id):
	
	var res = db.query("SELECT * FROM player WHERE player.game_id = " + str(match_id) + ";")
	if res:
		return db.query_result[0]
		
	return null
	
func set_player_lifes(lifes, game_id):
	
	var res = db.query("UPDATE player SET life = " + str(lifes) + " WHERE game_id = " + str(game_id) + ";")
	
	if res:
		print("updated")
		
