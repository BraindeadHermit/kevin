extends Area2D

signal life_added

func _on_body_entered(body):
	Kevin.add_life()
	emit_signal("life_added")
	$AnimationPlayer.play("bounce")
	set_collision_mask_value(0, false)

func _on_animation_player_animation_finished(anim_name):
	queue_free()
