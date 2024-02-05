extends Node2D

var level_access = level_dao.new()
var terminal_access = terminal_dao.new()

signal loaded

var terminals

func _init():
	Kevin.player_init()
	
	var level_id = level_access.create_new_level(Global.get_current_match_id(), "livello 1", "malware")
	
	terminals = terminal_access.get_terminals_by_level_id(level_id)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$terminal.set_data(terminals[0])
	$terminal2.set_data(terminals[1])
	$terminal3.set_data(terminals[2])
	$terminal4.set_data(terminals[3])
	$terminal5.set_data(terminals[4])
	
	
	
	
	
