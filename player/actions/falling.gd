extends BaseAction


func _on_falling_state_entered() -> void:
	animator.animate("jump_loop")


func _on_falling_state_physics_processing(delta: float) -> void:
	var move_dir = controller.get_free_move_direction()
	var current_velocity = Vector3(player.velocity.x, 0, player.velocity.z)
	var speed = max(current_velocity.length(), player.air_control/2) 

	var new_direction = current_velocity.normalized().slerp(move_dir, player.air_control * delta)
	var adjusted_velocity = new_direction * speed
	player.velocity.x = adjusted_velocity.x
	player.velocity.z = adjusted_velocity.z

	if controller.is_free_movement_type():
		var flat_dir = Vector3(player.velocity.x, 0, player.velocity.z)
		if flat_dir.length() > 0.1:
			var target_rotation = atan2(flat_dir.x, flat_dir.z) - player.rotation.y + PI
			player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	
	if controller.is_fixed_movement_type():
		look_to()
