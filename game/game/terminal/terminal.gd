extends Area2D

signal  completed(terminal_number: int, is_correct: bool)

var data: Dictionary
var question_access
var answer_access
var terminal_access

var terminal_number

var question
var answers

func _init():
	question_access = questions_dao.new()
	answer_access = answare_dao.new()
	terminal_access = terminal_dao.new()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	terminal_number = get_meta("question")
	$CanvasLayer.visible = false


func _on_body_entered(body):
	if $CanvasLayer.visible == false:
		$CanvasLayer.visible = true
	
	set_collision_mask_value(1, false)


func _on_question_answered_resp_1():
	on_question_answered(0)

func _on_question_answered_resp_2():
	on_question_answered(1)

func _on_question_answered_resp_3():
	on_question_answered(2)

func _on_question_answered_resp_4():
	on_question_answered(3)


func on_question_answered(answer_number):
	"""code for save the answare"""
	Kevin.add_question()
	
	await terminal_access.set_is_given(data["id"])
	await terminal_access.set_given_answer(data["id"], answer_number)
	$CanvasLayer.visible = false
	completed.emit(terminal_number, answers[answer_number]["is_correct"])

func _on_level_1_loaded(terminal_data):
	self.data = terminal_data[terminal_number]
	
	question = await question_access.get_question_by_id(data["question_id"])
	answers = await answer_access.get_answares_by_question_id(data["question_id"])
	
	if data["is_given"]:
		set_collision_mask_value(1, false)
		var ans_num = data["given_answer"]
		completed.emit(ans_num, answers[ans_num]["is_correct"])
		
	$CanvasLayer/Panel/Label.text = question["text"]
	
	$CanvasLayer/Panel/question/Label.text = answers[0]["text"]
	$CanvasLayer/Panel/question2/Label.text = answers[1]["text"]
	$CanvasLayer/Panel/question3/Label.text = answers[2]["text"]
	$CanvasLayer/Panel/question4/Label.text = answers[3]["text"]
	
	
	
