extends State


func enter():
	player.current_speed = player.running_speed
	

func update(delta: float) -> void:
	if not player.run_input.is_triggered():
		parent_fsm.change_state(parent_fsm.states["WalkingState"])
	
