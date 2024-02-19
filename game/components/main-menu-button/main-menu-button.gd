extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	$text.text = get_meta("button_text")
