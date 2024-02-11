extends Node2D


# Called when the node enters the scene tree for the first time.
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
	
	level_id = await  level_access.get_level_id_by_name("livello 2", Global.get_current_match_id())
	print(level_id)
	
	if level_id == -1:
		level_id = await level_access.create_new_level(Global.get_current_match_id(), "livello 2", "malware")
	
	var ans_questions = await level_access.get_answered_questions_number(level_id)
	
	Kevin.player_init(ans_questions)
	
	terminals = await terminal_access.get_terminals_by_level_id(level_id)
	
	await loaded.emit(terminals)
	
	collectables = await collectable_access.get_collectables_by_level_id(level_id)
	
	await collectables_setup.emit(collectables)
