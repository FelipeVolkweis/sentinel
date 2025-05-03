class_name State
extends FSM

var parent_fsm: FSM


func update(delta: float) -> void:
	pass


func execute(delta: float) -> void:
	print("On ", name)
	update(delta)
	if _current_state:
		_current_state.update(delta)
	

func enter():
	pass
	

func exit():
	pass
