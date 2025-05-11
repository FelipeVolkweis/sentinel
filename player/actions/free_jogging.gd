extends FreeMovement


func _on_jogging_state_physics_processing(delta: float) -> void:
	move_to(player.jogging_speed, delta)


func _on_jogging_state_entered() -> void:
	#animation_fsm.travel("Jog")
	animator.animate("jog")
