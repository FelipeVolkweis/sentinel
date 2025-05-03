class_name JumpState
extends State

var _should_jump: bool


func handle_input(input: GUIDEAction):
	_should_jump = input.is_triggered()


func update(delta: float):
	if player.is_on_floor() && _should_jump:
		player.velocity.y = player.jump_speed
