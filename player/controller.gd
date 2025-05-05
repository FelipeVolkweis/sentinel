extends Node


@onready var player := $".."


func _process(delta: float) -> void:
	if player.move_input.value_axis_3d.normalized() != Vector3.ZERO:
		player.state_chart.send_event("move_input")
	else:
		player.state_chart.send_event("no_move_input")
	
	if player.jump_input.is_triggered():
		player.state_chart.send_event("jump_input")
	
	if not player.is_on_floor():
		player.state_chart.send_event("airborne")
	else:
		player.state_chart.send_event("grounded")

	if player.run_input.is_triggered():
		player.state_chart.send_event("run_input")
	else:
		player.state_chart.send_event("no_run_input")
	
