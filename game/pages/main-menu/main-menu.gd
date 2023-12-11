extends Control

var images_url = ["res://assets/img/city.png", "res://assets/img/city2.png", "res://assets/img/hack.png", "res://assets/img/jet.png", "res://assets/img/motor.png", "res://assets/img/temple.png"]
var images = []
@onready var texture_rect = get_node("TextureRect")
@onready var description = get_node("description")
var thread = Thread.new()

func _on_texture_rect_ready():
	thread.start(_load_image)
	images = thread.wait_to_finish()
	
	if not thread.is_alive():
		var rng = RandomNumberGenerator.new()
		while true:
			var rand = rng.randi_range(0, 5)
			$TextureRect.texture = images[rand]
			await get_tree().create_timer(13).timeout
			$TextureRect.texture = null
			await get_tree().create_timer(1).timeout

func _load_image():
	var img = [load(images_url[0]), load(images_url[1]), load(images_url[2]), load(images_url[3]), load(images_url[4]), load(images_url[5])]
	return img

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://game/level_1/level_1.tscn")
