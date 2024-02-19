extends Control

var match_access = match_dao.new()

func _ready():
	match_access.delete_match_by_id(Global.get_current_match_id())


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()


func _on_texture_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://pages/main-menu/main-menu.tscn")


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
