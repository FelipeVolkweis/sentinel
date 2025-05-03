extends State


func update(delta: float) -> void:
	if player.is_on_floor() && player.jump_input.is_triggered():
		player.velocity.y = player.jump_speed
		parent_fsm.change_state(parent_fsm.states["AirborneState"])
		return
	
	var value = player.look_input.value_axis_1d
	player.rotation_degrees.y += value
