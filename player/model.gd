extends Node3D

@onready var player := $".."
@onready var controller := $"../Controller"

var _airborne_velocity := Vector3.ZERO

func _on_idling_state_processing(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.deceleration * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.deceleration * delta)


func _on_walking_state_processing(delta: float) -> void:
	_move_to(player.walking_speed, delta)


func _on_running_state_processing(delta: float) -> void:
	_move_to(player.running_speed, delta)


func _on_jumping_state_processing(delta: float) -> void:
	player.velocity.y = player.jump_speed
	_airborne_velocity = Vector3(player.velocity.x, 0, player.velocity.z)

func _on_airborne_state_processing(delta: float) -> void:
	var direction = controller.get_move_direction()
	var current_velocity = Vector3(player.velocity.x, 0, player.velocity.z)
	var speed = current_velocity.length()

	var new_direction = current_velocity.normalized().slerp(direction, player.air_control * delta)
	var adjusted_velocity = new_direction * speed
	
	var flat_dir = Vector3(player.velocity.x, 0, player.velocity.z)
	if flat_dir.length() > 0.1:
		var target_rotation = atan2(flat_dir.x, flat_dir.z) - player.rotation.y + PI
		player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	player.velocity.x = adjusted_velocity.x
	player.velocity.z = adjusted_velocity.z


func _move_to(speed: float, delta: float):
	var direction = controller.get_move_direction()
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	
	player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
	player.velocity.x = direction.x * speed
	player.velocity.z = direction.z * speed
