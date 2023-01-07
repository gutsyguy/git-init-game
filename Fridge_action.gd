extends RigidBody2D



func _on_Fridge_action_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		Global.at_fridge = true
		queue_free()
