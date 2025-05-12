extends BaseAction


func _on_idling_state_physics_processing(delta: float) -> void:
	player.stop(delta)
	if controller.is_fixed_movement_type():
		look_to()


func _on_idling_state_entered() -> void:
	animator.animate("idle")
