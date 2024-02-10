extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
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
	
	var given_ans = Kevin.get_answared_questions()
	
	$given_ans.text = "Risposte Date: " + str(given_ans) + "/5"
	$terminals/terminal_number.text = str(given_ans)
	
	
	if given_ans == 0:
		$give_answares/answare_1.texture = load("res://assets/graphic components/hud/no_answered.png")
		$give_answares/answare_2.texture = load("res://assets/graphic components/hud/no_answered.png")
		$give_answares/answare_3.texture = load("res://assets/graphic components/hud/no_answered.png")
		$give_answares/answare_4.texture = load("res://assets/graphic components/hud/no_answered.png")
		$give_answares/answare_5.texture = load("res://assets/graphic components/hud/no_answered.png")
		
	
