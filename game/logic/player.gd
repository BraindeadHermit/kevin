extends Node
class_name Player

var _lifes = 3


func add_life():
	if self._lifes < 3:
		self._lifes += 1
		
func death():
	if self._lifes >= 1:
		self._lifes -= 1
	else:
		"die"
