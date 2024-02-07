extends CharacterBody2D


const SPEED = 25.0
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
		direction = direction * -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		$floor_detector.position.x = $CollisionShape2D.shape.radius * direction

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = direction * SPEED

	move_and_slide()
