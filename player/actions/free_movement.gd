class_name FreeMovement
extends BaseAction

func move_to(speed: float, delta: float):
	var direction = controller.get_free_move_direction()
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	player.velocity = player.velocity.move_toward(direction * speed, player.movement_acceleration * delta)
