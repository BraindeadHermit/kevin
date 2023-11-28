extends Control

var images = [preload("res://assets/img/city.png"), preload("res://assets/img/city2.png"), preload("res://assets/img/hack.png"), preload("res://assets/img/jet.png"), preload("res://assets/img/motor.png"), preload("res://assets/img/temple.png")]

func _on_texture_rect_ready():
	var rng = RandomNumberGenerator.new()
	while true:
		var rand = rng.randi_range(0, 5)
		$TextureRect.texture = images[rand]
		await get_tree().create_timer(13).timeout
		$TextureRect.texture = null
		await get_tree().create_timer(1).timeout
