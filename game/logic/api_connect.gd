extends Node

const public_key = "testKey"
var http_request = HTTPRequest.new()
var question_access = questions_dao.new()
var answer_access = answare_dao.new()

func _ready():
	add_child(http_request)

func questions_update():
	var download_data_url = "https://tspr.ovh/api/quiz"
	var check_deletions_url = "https://tspr.ovh/api/question"
	
	var download_data_body = {
		"publicKey": "testKey",
		"company": Global.get_company_code()
	}
	
	http_request.request_completed.connect(_on_request_completed.bind())
	http_request.request(download_data_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify(download_data_body))

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if json["questions"] == []:
		return
	
	"""
		Scaricare evenutali nuove domande aggiunte al db remoto
	"""
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
	
	"""
		cancellazione delle domande immagazzinate in locale
		che non vengono trovate nel db remoto
		in modo da mantenere i db sincronizzati
	"""
	var db_qids = await question_access.get_all_questions_qid()
	
	var request_qids = []
	
	for question in json["questions"]:
		request_qids.append(question["QID"])
	
	for qid in db_qids:
		if request_qids.find(qid["qid"]) == -1:
			await question_access.delete_question(qid["qid"])
			await answer_access.delete_answers_by_qid(qid["qid"])

	
	
