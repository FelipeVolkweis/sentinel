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
	
	if player.walk_input.is_triggered():
		player.state_chart.send_event("walk_input")


func get_input_direction() -> Vector3:
	return player.move_input.value_axis_3d.normalized()


func get_move_direction() -> Vector3:
	var input_dir = get_input_direction()
	var camera_basis = player.camera.global_transform.basis

	var forward = camera_basis.z
	var right = camera_basis.x
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()

	var direction = (right * input_dir.x + forward * input_dir.z).normalized()
	
	return direction
