extends Node
class_name Player

var _lifes = 3
var _level1_answared_questions = 0;

func add_life():
	if self._lifes < 3:
		self._lifes += 1
		
func death():
	if self._lifes >= 1:
		self._lifes -= 1
	else:
		"die --> put a game over screen"

func get_lifes():
	return self._lifes

func add_question():
	self._level1_answared_questions += 1
	
func get_level1_answared_questions():
	return self._level1_answared_questions
