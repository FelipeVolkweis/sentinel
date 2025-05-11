extends BaseAction


func _on_idling_state_physics_processing(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.deceleration * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.deceleration * delta)
	if controller.is_fixed_movement_type():
		look_to()

func _on_idling_state_entered() -> void:
	animator.animate("idle")
