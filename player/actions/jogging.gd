extends BaseAction


func _on_jogging_state_physics_processing(delta: float) -> void:
	move_to(player.jogging_speed, delta)
	if controller.is_fixed_movement_type():
		animate_8way("jog")
		look_to()

func _on_jogging_state_entered() -> void:
	if controller.is_fixed_movement_type():
		animator.reset_8way()
	if controller.is_free_movement_type():
		animator.animate("jog")
