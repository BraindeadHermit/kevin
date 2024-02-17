extends CharacterBody2D

enum States { AIR, FLOOR, LADDERS, SHOT }
var state = States.AIR
var on_ladder := false
const SPEED = 300.0
const JUMP_VELOCITY = -350.0
const SHOT = preload("res://game/shot/shot.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func _ready():
	life_visual_setup()

func _physics_process(delta):
		
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				return
			elif is_on_ladder():
				state = States.LADDERS
				return
			
			velocity.y += gravity * delta
			
			if velocity.y > 0:
				anim.play("fall")
			
			var direction = direction_input()
			
			velocity.x = direction * SPEED
				
			move_and_slide()
			
		States.FLOOR:
			if not is_on_floor():
				state = States.AIR
				return
			elif is_on_ladder():
				state = States.LADDERS
				return
			
			var direction = direction_input()
			
			if direction:
				velocity.x = direction * SPEED
				if velocity.y == 0:
					if Input.is_action_just_pressed("ui_shoot"):
						shot(false)
						anim.play("run_shot")
						await  $AnimatedSprite2D.animation_finished
					else:
						anim.play("run")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				if velocity.y == 0:
					if Input.is_action_pressed("ui_down"):
						anim.play("duck")
						if Input.is_action_just_pressed("ui_shoot"):
							shot(true)
					elif Input.is_action_just_pressed("ui_shoot"):
						shot(false)
						anim.play("shoot")
						await  $AnimatedSprite2D.animation_finished
					else:	
						anim.play("idle")
				
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_VELOCITY
				anim.play("jump")
				$jump_audio.play()
				
			move_and_slide()
		States.LADDERS:
			if not on_ladder:
				state = States.AIR
				return
			elif is_on_floor() and Input.is_action_pressed("ui_down"):
				state = States.FLOOR
				Input.action_release("ui_down")
				Input.action_release("ui_up")
				return
			elif Input.is_action_pressed("ui_accept"):
				Input.action_release("ui_down")
				Input.action_release("ui_up")
				velocity.y = JUMP_VELOCITY * 0.7
				anim.play("jump")
				state = States.AIR
				return
			
			if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				anim.play("ladder")
			else:
				anim.stop()
			
			if Input.is_action_pressed("ui_up"):
				velocity.y = -SPEED/6
			elif Input.is_action_pressed("ui_down"):
				velocity.y = SPEED/6
				
			if Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED/6
			elif Input.is_action_pressed("ui_right"):
				velocity.x = SPEED/6
				
			if Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_up"):
				velocity.y = 0
			
			if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
				velocity.x = 0
				
			move_and_slide()

func _on_dangerzone_body_entered(body):
	Kevin.death()
	$fall.play()
	await $fall.finished
	get_tree().change_scene_to_file("res://game/level_1/level_1.tscn")
	
func _on_dangerzone_level_2_body_entered(body):
	Kevin.death()
	$fall.play()
	await $fall.finished
	get_tree().change_scene_to_file("res://game/level_2/level_2.tscn")

func direction_input() -> int:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	return direction

func shot(is_duck):
	var shot_direction = 1 if not $AnimatedSprite2D.flip_h else -1
	var shot_instance = SHOT.instantiate()
	shot_instance.direction = shot_direction
	get_parent().add_child(shot_instance)
	shot_instance.position.x = position.x + 10 * shot_direction
	if is_duck:
		shot_instance.position.y = position.y + 3
	else:
		shot_instance.position.y = position.y

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
	var given_ans = Kevin.get_answared_questions()
	$CanvasLayer/given_ans.text = "Risposte Date: " + str(given_ans) + "/5"
	$CanvasLayer/terminals/terminal_number.text = str(given_ans)
	
func hurt(enemy_position):
	Kevin.death()
	self.life_visual_setup()
	velocity.y = JUMP_VELOCITY * 0.7
	if enemy_position > position.x:
		position = lerp(position, Vector2(position.x - 150, position.y), 0.3)
	elif enemy_position < position.x:
		position = lerp(position, Vector2(position.x + 150, position.y), 0.3)
		
	Input.action_release("ui_accept")
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_shoot")
	Input.action_release("ui_down")
		
	anim.play("hurt")
	await  $AnimationPlayer.animation_finished

func _on_ladder_entered(body):
	on_ladder = true

func _on_ladder_exited(body):
	on_ladder = false

func is_on_ladder() -> bool:
	if on_ladder and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up")):
		return true
	
	return false
	
func is_answering():
	set_collision_layer_value(1, false)
	
func answering_exited():
	set_collision_layer_value(1, true)
