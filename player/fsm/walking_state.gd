extends State


func enter():
	player.current_speed = player.walking_speed


func update(delta: float) -> void:
	if player.run_input.is_triggered():
		parent_fsm.change_state(parent_fsm.states["RunningState"])
