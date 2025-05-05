extends Node3D

@onready var player := $".."


func _on_idling_state_processing(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.deceleration * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.deceleration * delta)


func _on_walking_state_processing(delta: float) -> void:
	_move_to(player.walking_speed, delta)


func _on_running_state_processing(delta: float) -> void:
	_move_to(player.running_speed, delta)


func _on_jumping_state_processing(delta: float) -> void:
	player.velocity.y = player.jump_speed


func _move_to(speed: float, delta: float):
	var input_dir = player.move_input.value_axis_3d.normalized()
	var camera_basis = player.camera.global_transform.basis

	var forward = camera_basis.z
	var right = camera_basis.x
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()

	var direction = (right * input_dir.x + forward * input_dir.z).normalized()

	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	player.velocity.x = direction.x * speed
	player.velocity.z = direction.z * speed
