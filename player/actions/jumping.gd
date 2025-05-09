extends BaseAction


func _on_jumping_state_entered() -> void:
	animation_fsm.travel("Jump_Start")
	player.velocity.y = player.jump_speed
