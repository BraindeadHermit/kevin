extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$terminals/Label2.text = str(0)
	
	if Kevin.get_lifes() == 3:
		$"life panel/life_1".visible = true
		$"life panel/life_2".visible = true
		$"life panel/life_3".visible = true
	elif 	Kevin.get_lifes() == 2:
		$"life panel/life_1".visible = true
		$"life panel/life_2".visible = true
		$"life panel/life_3".visible = false
	elif 	Kevin.get_lifes() == 1:
		$"life panel/life_1".visible = true
		$"life panel/life_2".visible = false
		$"life panel/life_3".visible = false
	
