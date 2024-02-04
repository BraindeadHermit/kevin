extends Node
class_name Player

var _lifes: int
var _damage: int
var _level1_answared_questions = 0;

func player_init():
	var player = Database.get_player_by_match_id(Global.get_current_match_id())
	self._lifes = player["life"]
	self._damage = player["damage_amount"]
	print("current lifes: " + str(self._lifes))

func add_life():
	if self._lifes < 3:
		self._lifes += 1
		Database.set_player_lifes(self._lifes, Global.get_current_match_id())
		
func death():
	if self._lifes >= 1:
		self._lifes -= 1
		Database.set_player_lifes(self._lifes, Global.get_current_match_id())
	else:
		"die --> put a game over screen"

func get_lifes():
	return self._lifes

func add_question():
	self._level1_answared_questions += 1
	
func get_level1_answared_questions():
	return self._level1_answared_questions
