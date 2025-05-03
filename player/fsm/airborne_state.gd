extends State


func update(delta: float) -> void:
	if player.is_on_floor():
		parent_fsm.change_state(parent_fsm.states["GroundedState"])
