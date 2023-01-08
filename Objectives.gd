extends Label



func _process(delta):
	if Global.at_fridge:
		Global.at_fridge = false
		Global.is_cutscene = true
		yield(get_tree().create_timer(3),"timeout")
		text = "Objective: ..."
		yield(get_tree().create_timer(5),"timeout")
		text = "Objective: eSCaPe!!"
		Global.is_cutscene = false
		Global.is_chased = true
