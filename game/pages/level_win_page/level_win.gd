extends Control




func _on_next_level_pressed():
	Kevin.reset_ans_questions()
	get_tree().call_deferred("change_scene_to_file", "res://game/level_2/level_2.tscn")


func _on_home_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://pages/main-menu/main-menu.tscn")


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
