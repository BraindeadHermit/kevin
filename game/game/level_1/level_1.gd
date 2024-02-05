extends Node2D

var level_access = level_dao.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Kevin.player_init()
	
	level_access.create_new_level(Global.get_current_match_id(), "livello 1", "malware")
	
	
	
	
