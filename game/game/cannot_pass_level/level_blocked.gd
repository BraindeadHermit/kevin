extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_panel_visibility_changed():
	if self.visible == true:
		$AnimationPlayer.play("get_visible")
	elif self.visible == false:
		$AnimationPlayer.play("get_invisible")
