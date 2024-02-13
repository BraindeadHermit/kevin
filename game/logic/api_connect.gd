extends Node

const public_key = "testKey"
var http_request = HTTPRequest.new()
var question_access = questions_dao.new()
var answer_access = answare_dao.new()

func _ready():
	add_child(http_request)

func questions_update():
	print("begin request")
	var url = "https://tspr.ovh/api/quiz"
	
	var req_body = {
		"publicKey": "testKey",
		"company": "CODE_01"
	}
	
	http_request.request_completed.connect(_on_request_completed.bind())
	http_request.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify(req_body))

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if json["questions"] == []:
		return
	
	for question in json["questions"]:
		var q = await question_access.get_question_by_qid(question["QID"])
		if q != null:
			if question["QID"] == q["qid"]:
				continue
					
		var question_entery = Dictionary()
		question_entery["qid"] = question["QID"]
		question_entery["category"] = question["Category"]
		question_entery["text"] = question["Body"]
		question_entery["company_code"] = question["Company"]
				
		await question_access.create_question(question_entery)
				
		for answer in question["Options"]:
			var answer_entery = Dictionary()
			answer_entery["question_qid"] = question["QID"]
			answer_entery["text"] = answer[0]
			answer_entery["is_correct"] = answer[1]
			
			await answer_access.create_answer(answer_entery)
