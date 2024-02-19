extends Control


func _ready():
	pass


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()


func _on_texture_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://pages/main-menu/main-menu.tscn")


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
