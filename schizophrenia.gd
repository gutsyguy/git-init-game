extends Node2D

var box = preload("res://barricade.tscn")

var monster = preload("res://monster.tscn")

func _process(delta):

	
	if Global.is_chased:
		$Player/ColorRect.color = Color(1,0,0,.7)
		$Rain.volume_db = -5
	if Global.normal:
		$Player/ColorRect.color = Color(1,0,0,0)
		$Rain.volume_db = 0
		
	if Global.at_fridge:
		yield(get_tree().create_timer(3),"timeout")
		$tiles/CanvasModulate.color = Color(0,0,0,1)
		$"Light Switch".play()
		yield(get_tree().create_timer(3),"timeout")
		$tiles/CanvasModulate.color = Color(0.160784,0.160784,0.160784,1)
		var evil = monster.instance()
		evil.position = Vector2(70,425)
		add_child(evil)
		yield(get_tree().create_timer(2),"timeout")
		
	if Global.enter_storage:
		var barriacde = box.instance()
		barriacde.position = Vector2(1032,423)
		add_child(barriacde)
		Global.enter_storage = false
		Global.monster_blocked = true
		
	if Global.has_pill:
		Global.is_cutscene = true
		Global.is_chased = false
		var evil = monster.instance()
		Global.has_pill = false
		evil.position = Vector2(1680,355)
		add_child(evil)
		yield(get_tree().create_timer(2),"timeout")
		$pill_dialogue.visible = true
		yield(get_tree().create_timer(3),"timeout")
		$tiles/CanvasModulate.color = Color(0.807843,0.807843,0.807843,1)
		evil.queue_free()
		Global.normal = true
		Global.is_cutscene = false



