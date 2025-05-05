extends Node3D

@onready var player := $".."


func _on_idling_state_processing(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.deceleration * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.deceleration * delta)
	


func _on_walking_state_processing(delta: float) -> void:
	var input_dir = player.move_input.value_axis_3d.normalized()
	var camera_basis = player.camera.global_transform.basis		
	var direction = (camera_basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	
	player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	var root_motion = player.visuals.animator.get_root_motion_position() / delta
	player.velocity.x = direction.x * player.walking_speed
	player.velocity.z = direction.z * player.walking_speed


func _on_jumping_state_processing(delta: float) -> void:
	player.velocity.y = player.jump_speed
