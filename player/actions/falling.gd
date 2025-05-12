extends BaseAction


func _on_falling_state_entered() -> void:
	animator.animate("jump_loop")


func _on_falling_state_physics_processing(delta: float) -> void:
	var direction = controller.get_free_move_direction()
	player.air_strafe(direction, delta)

	if controller.is_free_movement_type():
		player.rotate_to(player.velocity, delta)
	
	if controller.is_fixed_movement_type():
		look_to()
