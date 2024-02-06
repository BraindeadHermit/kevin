extends Node2D

var level_access = level_dao.new()
var terminal_access = terminal_dao.new()
var collectable_access = collectable_dao.new()

signal loaded(terminal_data)
signal collectables_setup(collectables_data)

var terminals
var collectables
var level_id
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Kevin.player_init()
	
	level_id = await level_access.create_new_level(Global.get_current_match_id(), "livello 1", "malware")
	
	var answered = await level_access.get_answered_questions_number(level_id)
	
	Kevin.set_level1_given_questions(answered)
	
	terminals = await terminal_access.get_terminals_by_level_id(level_id)
	
	await loaded.emit(terminals)
	
	collectables = await collectable_access.get_collectables_by_level_id(level_id)
	
	await collectables_setup.emit(collectables)

func _on_area_2d_body_entered(body):
	var ans_questions = await level_access.get_answered_questions_number(level_id)
	if ans_questions == 5:
		print("Level Passed")
	else:
		print("Non hai risposto a tutte le domande")
