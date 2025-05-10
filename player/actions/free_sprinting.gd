extends FreeMovement


func _on_sprinting_state_physics_processing(delta: float) -> void:
	move_to(player.sprinting_speed, delta)


func _on_sprinting_state_entered() -> void:
	animation_fsm.travel("Sprint")
