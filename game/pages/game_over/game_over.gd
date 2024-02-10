extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_riprova_pressed():
	Kevin.restart_game()
	get_tree().call_deferred("change_scene_to_file", "res://game/level_1/level_1.tscn")


func _on_home_page_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://pages/main-menu/main-menu.tscn")


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
