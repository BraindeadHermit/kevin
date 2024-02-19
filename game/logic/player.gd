extends Node
class_name Player

var _lifes: int
var _damage: int
var _answared_questions: int;

var player_access = player_dao.new()

func player_init(ans_questions):
	var player = await player_access.get_player_by_match_id(Global.get_current_match_id())
	self._lifes = player["life"]
	self._damage = player["damage_amount"]
	self._answared_questions = ans_questions

func add_life():
	if self._lifes < 3:
		self._lifes += 1
		player_access.set_player_lifes(self._lifes, Global.get_current_match_id())
		
func death():
	if self._lifes > 1:
		self._lifes -= 1
		player_access.set_player_lifes(self._lifes, Global.get_current_match_id())
	else:
		var game_over = load("res://pages/game_over/game_over.tscn")
		get_tree().call_deferred('change_scene_to_packed', game_over)

func get_lifes():
	return self._lifes

func add_question():
	self._answared_questions += 1
	
func set_given_questions(given_questions):
	self._answared_questions = given_questions
	
func get_answared_questions():
	return self._answared_questions
	
func restart_game():
	self._lifes = 3
	player_access.set_player_lifes(3, Global.get_current_match_id())
	
func reset_ans_questions():
	self._answared_questions = 0
