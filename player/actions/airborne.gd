extends BaseAction


func _on_airborne_state_physics_processing(delta: float) -> void:
	var input_dir = controller.get_input_direction()
	var move_dir = controller.get_move_direction()
	var current_velocity = Vector3(player.velocity.x, 0, player.velocity.z)
	var speed = max(current_velocity.length(), player.air_control/2) 

	if input_dir.z > 0:
		var deceleration = player.air_control * delta
		var decel_velocity = current_velocity * (1.0 - deceleration)
		player.velocity.x = decel_velocity.x
		player.velocity.z = decel_velocity.z
	else:
		if move_dir.length() > 0.1 and speed > 0.01:
			var new_direction = current_velocity.normalized().slerp(move_dir, player.air_control * delta)
			var adjusted_velocity = new_direction * speed
			player.velocity.x = adjusted_velocity.x
			player.velocity.z = adjusted_velocity.z

	var flat_dir = Vector3(player.velocity.x, 0, player.velocity.z)
	if flat_dir.length() > 0.1:
		var target_rotation = atan2(flat_dir.x, flat_dir.z) - player.rotation.y + PI
		player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
