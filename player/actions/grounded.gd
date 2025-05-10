extends BaseAction


func _on_grounded_state_physics_processing(delta: float) -> void:
	pass
	#player.rotation_degrees.y += player.look_input.value_axis_1d * delta * 90
#
	#var input_dir = player.move_input.value_axis_3d
	#var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
#
	#player.velocity.x = direction.x * player.jogging_speed
	#player.velocity.z = direction.z * player.jogging_speed
