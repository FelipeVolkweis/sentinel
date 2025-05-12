class_name BaseAction
extends Node

@export var player: PlayerBody
@export var controller: Controller
@export var animator: Animator

func move_to(speed: float, delta: float):
	var direction = controller.get_free_move_direction()
	player.move_to(direction, speed, delta)
	
	if controller.is_free_movement_type():
		player.rotate_to(direction, delta)


func look_to():
	var value = controller.yaw_input.value_axis_1d
	player.rotate_by(value)


func animate_8way(animation: String):
	var input_vector_2d := Vector2(controller.get_input_direction().x, -controller.get_input_direction().z)
	animator.animate_8way(animation, input_vector_2d)
