extends Node


@onready var player := $".."

var moving := false
var airborne := false
var grounded := false
var sprinting := false
var walking := false


func _process(delta: float) -> void:
	moving = player.move_input.value_axis_3d.normalized() != Vector3.ZERO
	player.state_chart.set_expression_property("moving", moving)
	
	if player.jump_input.is_triggered():
		player.state_chart.send_event("jump_input")
	
	airborne = !player.is_on_floor()
	grounded = player.is_on_floor()
	player.state_chart.set_expression_property("airborne", airborne)
	player.state_chart.set_expression_property("grounded", grounded)

	sprinting = player.run_input.is_triggered()
	walking = player.walk_input.is_triggered()
	player.state_chart.set_expression_property("sprinting", sprinting)
	player.state_chart.set_expression_property("walking", walking)
		
	_camera_input_handler()


func _camera_input_handler():
	if player.camera_toggle_input.is_triggered():
		player.camera_type = (player.camera_type + 1) % player.CameraType.size()
	
	match player.camera_type:
		player.CameraType.FREE:
			player.camera.current = false
			player.camera = player.free_camera
			player.camera.current = true
			
			player.state_chart.send_event("free_movement")
			if not player.is_on_floor():
				player.state_chart.send_event("free_fall")
		player.CameraType.FIXED:
			player.camera.current = false
			player.camera = player.fixed_camera
			player.camera.current = true
			
			player.state_chart.send_event("fixed_movement")
			if not player.is_on_floor():
				player.state_chart.send_event("fixed_fall")
		_:
			pass


func get_input_direction() -> Vector3:
	return player.move_input.value_axis_3d


func get_free_move_direction() -> Vector3:
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
