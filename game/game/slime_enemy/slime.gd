extends CharacterBody2D


var SPEED = 25.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var direction = -1
@export var should_detect_floor = true

func _ready():
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	
	$floor_detector.enabled = should_detect_floor
	if should_detect_floor:
		$floor_detector.position.x = $CollisionShape2D.shape.radius * direction

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif is_on_wall() or (not $floor_detector.is_colliding() and should_detect_floor):
		turn(direction * -1, not $AnimatedSprite2D.flip_h)
	
	velocity.x = direction * SPEED

	move_and_slide()


func _on_player_detector_body_entered(body):
	if body.get_collision_layer() == 1:
		body.hurt(position.x)
	elif body.get_collision_layer() == 32:
		body.destroy()
		$player_hurt.set_collision_mask_value(1, false)
		velocity.x = 0
		$AnimatedSprite2D.play("die")
		await $AnimatedSprite2D.animation_finished
		queue_free()

func _on_player_detected(body):
	SPEED = 75.0
	if body.position.x < position.x:
		turn(-1, false)
	elif body.position.x > position.x:
		turn(1, true)

func _on_player_not_detected(body):
	SPEED = 25.0
	
func turn(new_direction, flip_sprite):
	direction = new_direction
	$AnimatedSprite2D.flip_h = flip_sprite
	$floor_detector.position.x = $CollisionShape2D.shape.radius * direction
