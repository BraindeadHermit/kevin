extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	var label = get_node("HBoxContainer/text")
	label.text = get_meta("button_text")
