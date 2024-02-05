extends Area2D

signal  completed
var data: Dictionary
var question_access
var answer_access

func _init():
	question_access = questions_dao.new()
	answer_access = answare_dao.new()

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
	
func set_data(data):
	self.data = data
	var question = question_access.get_question_by_id(data["question_id"])
	var answers = answer_access.get_answares_by_question_id(data["question_id"])
	$CanvasLayer/Panel/Label.text = question["text"]
	
	$CanvasLayer/Panel/question/Label.text = answers[0]["text"]
	$CanvasLayer/Panel/question2/Label.text = answers[1]["text"]
	$CanvasLayer/Panel/question3/Label.text = answers[2]["text"]
	$CanvasLayer/Panel/question4/Label.text = answers[3]["text"]
	
