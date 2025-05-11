class_name FixedMovement
extends BaseAction

func move_to(speed: float, delta: float):
	var input_dir = player.move_input.value_axis_3d.normalized()
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	player.velocity.x = direction.x * speed
	player.velocity.z = direction.z * speed


func look_to():
	var value = player.look_input.value_axis_1d
	player.rotation_degrees.y += value


func _on_fixed_movement_state_entered() -> void:
	player.visuals.rotation.y = 0
