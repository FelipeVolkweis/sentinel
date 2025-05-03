class_name MoveState
extends State

var _input_dir: Vector3
func handle_input(input: GUIDEAction):
	_input_dir = input.value_axis_3d.normalized()

func update(delta: float):
	var direction = (player.transform.basis * Vector3(_input_dir.x, 0, _input_dir.z)).normalized()
	player.velocity.x = direction.x * player.movement_speed
	player.velocity.z = direction.z * player.movement_speed
