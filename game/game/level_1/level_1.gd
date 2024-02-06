extends Node2D

var level_access = level_dao.new()
var terminal_access = terminal_dao.new()

signal loaded(terminal_data)

var terminals
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Kevin.player_init()
	
	var level_id = await level_access.create_new_level(Global.get_current_match_id(), "livello 1", "malware")
	
	var answered = await level_access.get_answered_questions_number(level_id)
	
	Kevin.set_level1_given_questions(answered)
	
	terminals = await terminal_access.get_terminals_by_level_id(level_id)
	
	await loaded.emit(terminals)
	
	
	
	
