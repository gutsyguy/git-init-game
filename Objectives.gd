extends Label


func _process(delta):
	if Global.at_fridge:
		text = "Objective: ..."
		$fridge_timer.start(3)
		Global.at_fridge = false
		Global.is_cutscene = true



func _on_fridge_timer_timeout():
	text = "Objective: eSCaPe!!"
	Global.is_cutscene = false
	Global.is_chased = true
