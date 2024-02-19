extends Control

@onready var texture_rect = get_node("TextureRect")
@onready var description = get_node("description")
var thread = Thread.new()

var match_access = match_dao.new()
var to_send_access = to_send_dao.new()

var _current_qid

func _ready():
	ApiConnect.questions_update()
	var to_send = await to_send_access.get_all_to_send()
	if to_send != []:
		for question in to_send:
			if question["company"] == Global.get_company_code():
				var http_request = HTTPRequest.new()
				add_child(http_request)
				var submit_body = {
					"publicKey": "testKey",
					"company": question["company"],
					"qid": question["qid"],
					"platform": question["platform"],
					"options": [question["option_1"] == 1, question["option_2"] == 1, question["option_3"] == 1, question["option_4"] == 1]
				}
				
				_current_qid = question["qid"]
				http_request.request_completed.connect(_on_http_request_request_completed.bind())
				await http_request.request("https://tspr.ovh/api/answer", ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify(submit_body))
				await http_request.request_completed
				http_request.queue_free()
			else:
				await to_send_access.delete_to_send(question["qid"])
	

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	var game_id = await match_access.create_new_match(Global.get_username(), Global.get_company_code())
	Global.set_current_match_id(game_id)
	Kevin.restart_game()
	get_tree().call_deferred("change_scene_to_file", "res://game/level_1/level_1.tscn")

func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 0:
		return
	print(_current_qid)
	if response_code == 200:
		await to_send_access.delete_to_send(_current_qid)


func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()
