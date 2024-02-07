extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		
	if velocity.y > 0:
		anim.play("fall")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			if Input.is_action_pressed("ui_shoot"):
				anim.play("run_shot")
			else:
				anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			if Input.is_action_pressed("ui_down"):
				anim.play("duck")
			elif Input.is_action_pressed("ui_shoot"):
				anim.play("shoot")
			else:	
				anim.play("idle")

	move_and_slide()


func _on_dangerzone_body_entered(body):
	Kevin.death()
	get_tree().change_scene_to_file("res://game/level_1/level_1.tscn")




func _on_add_life_life_added():
	self.life_visual_setup()

func _on_add_life_2_life_added():
	self.life_visual_setup()

func life_visual_setup():
	if Kevin.get_lifes() == 3:
		$"CanvasLayer/life panel/life_1".visible = true
		$"CanvasLayer/life panel/life_2".visible = true
		$"CanvasLayer/life panel/life_3".visible = true
	elif 	Kevin.get_lifes() == 2:
		$"CanvasLayer/life panel/life_1".visible = true
		$"CanvasLayer/life panel/life_2".visible = true
		$"CanvasLayer/life panel/life_3".visible = false
	elif 	Kevin.get_lifes() == 1:
		$"CanvasLayer/life panel/life_1".visible = true
		$"CanvasLayer/life panel/life_2".visible = false
		$"CanvasLayer/life panel/life_3".visible = false

func _on_terminal_1_completed(terminal_number, is_correct):
	completed_answer()
	if is_correct:
		$CanvasLayer/give_answares/answare_1.texture = load("res://assets/graphic components/hud/correct.png")
	else:
		$CanvasLayer/give_answares/answare_1.texture = load("res://assets/graphic components/hud/wrong.png")

func _on_terminal_2_completed(terminal_number, is_correct):
	completed_answer()
	if is_correct:
		$CanvasLayer/give_answares/answare_2.texture = load("res://assets/graphic components/hud/correct.png")
	else:
		$CanvasLayer/give_answares/answare_2.texture = load("res://assets/graphic components/hud/wrong.png")

func _on_terminal_3_completed(terminal_number, is_correct):
	completed_answer()
	if is_correct:
		$CanvasLayer/give_answares/answare_3.texture = load("res://assets/graphic components/hud/correct.png")
	else:
		$CanvasLayer/give_answares/answare_3.texture = load("res://assets/graphic components/hud/wrong.png")

func _on_terminal_4_completed(terminal_number, is_correct):
	completed_answer()
	if is_correct:
		$CanvasLayer/give_answares/answare_4.texture = load("res://assets/graphic components/hud/correct.png")
	else:
		$CanvasLayer/give_answares/answare_4.texture = load("res://assets/graphic components/hud/wrong.png")

func _on_terminal_5_completed(terminal_number, is_correct):
	completed_answer()
	if is_correct:
		$CanvasLayer/give_answares/answare_5.texture = load("res://assets/graphic components/hud/correct.png")
	else:
		$CanvasLayer/give_answares/answare_5.texture = load("res://assets/graphic components/hud/wrong.png")
	
func completed_answer():
	var given_ans = Kevin.get_level1_answared_questions()
	$CanvasLayer/given_ans.text = "Risposte Date: " + str(given_ans) + "/5"
	$CanvasLayer/terminals/terminal_number.text = str(given_ans)
	
func hurt(enemy_position):
	Kevin.death()
	self.life_visual_setup()
	velocity.y = JUMP_VELOCITY * 0.5
	if enemy_position > position.x:
		velocity.x = -1000
	elif enemy_position < position.x:
		velocity.x = 1000
		
	Input.action_release("ui_accept")
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_shoot")
	Input.action_release("ui_down")
		
	anim.play("hurt")
	await  $AnimationPlayer.animation_finished
