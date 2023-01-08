extends RigidBody2D


func _on_bottle_action_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		Global.has_pill = true
		$CollisionShape2D/AudioStreamPlayer.play()
		yield(get_tree().create_timer(1),"timeout")
		queue_free()
