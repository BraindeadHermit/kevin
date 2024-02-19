extends Control

var level_access = level_dao.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_riprova_pressed():
	Kevin.restart_game()
	var is_completed = await level_access.is_level_completed("livello 1", Global.get_current_match_id())
	if is_completed:
		get_tree().call_deferred("change_scene_to_file", "res://game/level_2/level_2.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://game/level_1/level_1.tscn")


func _on_home_page_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://pages/main-menu/main-menu.tscn")


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
