extends State


func update(delta: float) -> void:
	if player.move_input.value_axis_3d.normalized() != Vector3.ZERO:
		parent_fsm.change_state(parent_fsm.states["RunningState"])
