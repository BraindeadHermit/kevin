extends Area2D

signal  completed
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.visible = false


func _on_body_entered(body):
	if $CanvasLayer.visible == false:
		$CanvasLayer.visible = true
	
	set_collision_mask_value(1, false)


func _on_question_answered_resp_1():
	on_question_answered()

func _on_question_answered_resp_2():
	on_question_answered()

func _on_question_answered_resp_3():
	on_question_answered()

func _on_question_answered_resp_4():
	on_question_answered()


func on_question_answered():
	"""code for save the answare"""
	Kevin.add_question()
	$CanvasLayer.visible = false
	emit_signal("completed")
