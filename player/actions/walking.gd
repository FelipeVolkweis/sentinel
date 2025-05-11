extends BaseAction


func _on_walking_state_physics_processing(delta: float) -> void:
	move_to(player.walking_speed, delta)
	if controller.is_fixed_movement_type():
		animate_8way("walk")
		look_to()


func _on_walking_state_entered() -> void:
	if controller.is_fixed_movement_type():
		animator.reset_8way()
	if controller.is_free_movement_type():
		animator.animate("walk")
