extends CharacterBody2D


const SPEED = 300.0
var direction = 1

func _ready():
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("shot")
	velocity.x = direction * SPEED

func _physics_process(delta):

	if is_on_wall():
		$AnimatedSprite2D.play("hit")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	
	move_and_slide()
	
func destroy():
	$AnimatedSprite2D.play("hit")
	queue_free()
	
func _on_shot_screen_exited():
	queue_free()


func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
