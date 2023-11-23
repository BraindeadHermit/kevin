extends TextureButton

var text = ""
var button_label = null
# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_meta("button_text")
	button_label = get_node("CenterContainer/Label")
	button_label.text = text;
