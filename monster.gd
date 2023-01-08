extends KinematicBody2D

var speed = 230

var vertical_speed = 10

var go_back_time = 0

var encounter

func _ready():
	$AnimationPlayer.play("death")
	$Timer.start(2)
	
	if !Global.monster_blocked:
		encounter = 1
	else:
		encounter = 2


func _physics_process(delta):
	var velocity = Vector2.ZERO
	print(encounter)
	if encounter == 1:
		print("first")
		yield(get_tree().create_timer(4.5),"timeout")
		velocity = Vector2(1,0) * speed
		velocity = move_and_slide(velocity)
	elif encounter == 2:
		if position.y > 307:
			print("second")
			velocity = Vector2(0,1) * vertical_speed
			position -= velocity * delta
	print(velocity)


	


func _on_Timer_timeout():
	if !Global.monster_blocked || encounter == 2:
		$AnimationPlayer.play("forward")
	if Global.monster_blocked && encounter == 1:
		$AnimationPlayer.play("attack")
		go_back_time += 1
	if go_back_time > 10 && encounter == 1:
		$monsterSprite.flip_h = true
		speed *= -1
		yield(get_tree().create_timer(3),"timeout")
		encounter = 2
		queue_free()
	else:
		$Timer.start(0.6)
