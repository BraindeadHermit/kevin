extends Node2D

var anim = null

func _on_ready():
	anim = $Control/AnimationPlayer
	anim.play("menu_fade_in")

func _on_quit_pressed():
	get_tree().quit()

