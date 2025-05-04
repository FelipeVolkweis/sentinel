extends State


func update(delta: float) -> void:
	if player.move_input.value_axis_3d.normalized() == Vector3.ZERO:
		parent_fsm.change_state(parent_fsm.states["IdlingState"])
	
	var input_dir = player.move_input.value_axis_3d.normalized()
	var camera_basis = player.camera.global_transform.basis		
	var direction = (camera_basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	
	player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta) 
	player.velocity.x = direction.x * player.current_speed
	player.velocity.z = direction.z * player.current_speed
