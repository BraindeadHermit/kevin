extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	var label = get_node("HBoxContainer/text")
	label.text = get_meta("button_text")
	var root = get_node("HBoxContainer/root")
	root.text = Global.get_username()
	

func _on_root_resized():
	var x = $HBoxContainer/text.size.x + $HBoxContainer/root.size.x + $HBoxContainer/tilde.size.x + $HBoxContainer/dollar.size.x + 10
	self.set_size(Vector2(x, self.size.y))
