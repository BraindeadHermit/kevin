extends TextureButton

signal question_answered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_pressed():
	"""Code for answare setting"""
	emit_signal("question_answered")
