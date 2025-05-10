extends FixedMovement


func _on_jogging_state_physics_processing(delta: float) -> void:
	look_to()
	move_to(player.jogging_speed, delta)
	var input_vector_2d := Vector2(controller.get_input_direction().x, -controller.get_input_direction().z)
	var old_input_vector_2d = animation_tree.get("parameters/JogBlendSpace/blend_position")
	var lerped_input = lerp(old_input_vector_2d, input_vector_2d, 0.2)
	animation_tree.set("parameters/JogBlendSpace/blend_position", lerped_input)


func _on_jogging_state_entered() -> void:
	animation_fsm.travel("JogBlendSpace")
