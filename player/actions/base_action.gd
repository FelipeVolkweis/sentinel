class_name BaseAction
extends Node

@export var player: CharacterBody3D
@export var controller: Controller
@export var animator: Animator

func move_to(speed: float, delta: float):
	var direction = controller.get_free_move_direction()
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
	player.velocity = player.velocity.move_toward(direction * speed, player.movement_acceleration * delta)
	
	if controller.is_free_movement_type():
		player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)


func look_to():
	var value = controller.yaw_input.value_axis_1d
	player.rotation_degrees.y += value


func animate_8way(animation: String):
	var input_vector_2d := Vector2(controller.get_input_direction().x, -controller.get_input_direction().z)
	animator.animate_8way(animation, input_vector_2d)
