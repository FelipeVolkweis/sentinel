extends FixedMovement


func _on_jogging_state_physics_processing(delta: float) -> void:
	look_to()
	move_to(player.jogging_speed, delta)
	var input_vector_2d := Vector2(controller.get_input_direction().x, -controller.get_input_direction().z)
	animator.animate_8way("jog", input_vector_2d)


func _on_jogging_state_entered() -> void:
	animator.reset_8way()
