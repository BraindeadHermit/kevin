extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	var button_text = get_meta("button_text")
	get_node("ButtonText").text = button_text
	
