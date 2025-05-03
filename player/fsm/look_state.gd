class_name LookState
extends State

var _value: float

func handle_input(input: GUIDEAction):
	_value = input.value_axis_1d

func update(delta: float):
	player.rotation_degrees.y += _value
