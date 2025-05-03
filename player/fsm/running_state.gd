extends State


func update(delta: float) -> void:
	if player.move_input.value_axis_3d.normalized() == Vector3.ZERO:
		parent_fsm.change_state(parent_fsm.states["IdlingState"])
	
	var input_dir = player.move_input.value_axis_3d.normalized()
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	player.velocity.x = direction.x * player.movement_speed
	player.velocity.z = direction.z * player.movement_speed
