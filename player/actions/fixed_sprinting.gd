extends FixedMovement


func _on_sprinting_state_entered() -> void:
	animator.reset_8way()


func _on_sprinting_state_physics_processing(delta: float) -> void:
	look_to()
	move_to(player.sprinting_speed, delta)
	var input_vector_2d := Vector2(controller.get_input_direction().x, -controller.get_input_direction().z)
	animator.animate_8way("sprint", input_vector_2d)
